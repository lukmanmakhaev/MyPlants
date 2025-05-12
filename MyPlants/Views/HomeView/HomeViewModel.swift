//
//  ViewMode.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 08.05.2025.
//

import Foundation
import CoreData

class HomeViewModel: ObservableObject {
    private let viewContext: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.viewContext = context
    }
    
    @Published var name: String = ""
    @Published var latinName: String = ""
    @Published var descriptionText: String = ""
    @Published var kingdom: String = ""
    @Published var phylum: String = ""
    @Published var plantClass: String = ""
    @Published var order: String = ""
    @Published var family: String = ""
    @Published var genus: String = ""
    
    func addPlant() {
        let plant = Plant(context: viewContext)
        plant.id = UUID()
        plant.name = name
        plant.latinName = latinName
        plant.descriptionText = descriptionText
        plant.kingdom = kingdom
        plant.phylum = phylum
        plant.plantClass = plantClass
        plant.order = order
        plant.family = family
        plant.genus = genus
        plant.createdAt = Date()
        
        saveContext()
        
        reset()
    }
    
    private func saveContext() {
        do {
            if viewContext.hasChanges {
                try viewContext.save()
                print("Context saved successfully")
            } else {
                print("No changes to save in context")
            }
        } catch {
            print("Error saving context: \(error)")
        }
    }
    
    func deletePlant(_ plant: Plant) {
        print("deletePlant called for: \(plant.name ?? "Unknown")")
        viewContext.delete(plant)
        
        do {
            if viewContext.hasChanges {
                try viewContext.save()
                print("Plant deleted and context saved.")
            } else {
                print("No changes to save after deletion.")
            }
        } catch {
            print("Error saving context after deletion: \(error)")
        }
    }
    
    func deleteAllPlants() {
        print("deleteAllPlants called")
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Plant.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try viewContext.execute(deleteRequest)
            
            saveContext()
        } catch {
            print("Failed to delete all plants: \(error)")
        }
    }
    
    func addMockPlants(count: Int = 10) {
        print("addMockPlants called")
        for i in 1...count {
            let plant = Plant(context: viewContext)
            plant.id = UUID()
            plant.name = "Mock Plant \(i)"
            plant.latinName = "Latin Name \(i)"
            plant.descriptionText = "Description for plant \(i)"
            plant.kingdom = "Kingdom \(i)"
            plant.phylum = "Phylum \(i)"
            plant.plantClass = "Class \(i)"
            plant.order = "Order \(i)"
            plant.family = "Family \(i)"
            plant.genus = "Genus \(i)"
            plant.percent = "67,6"
            plant.createdAt = Date().addingTimeInterval(Double(-i) * 86400)
            print("Added plant: \(plant.name ?? "Unknown")")
        }
        saveContext()
    }
    
    private func reset() {
        name = ""
        latinName = ""
        descriptionText = ""
        kingdom = ""
        phylum = ""
        plantClass = ""
        order = ""
        family = ""
        genus = ""
    }
}
