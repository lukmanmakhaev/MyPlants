//
//  ViewMode.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 08.05.2025.
//

import Foundation
import CoreData

class HomeViewModel: ObservableObject {
    @Published var plants: [Plant] = []
    
    @Published var name: String = ""
    @Published var latinName: String = ""
    @Published var descriptionText: String = ""
    @Published var kingdom: String = ""
    @Published var phylum: String = ""
    @Published var plantClass: String = ""
    @Published var order: String = ""
    @Published var family: String = ""
    @Published var genus: String = ""
    
    private let viewContext: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.viewContext = context
        fetchPlants()
    }
    
    func fetchPlants() {
        let request: NSFetchRequest<Plant> = Plant.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Plant.createdAt, ascending: false)]
        
        do {
            plants = try viewContext.fetch(request)
        } catch {
            print("Ошибка при загрузке растений: \(error)")
        }
    }
    
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
            try viewContext.save()
            fetchPlants()
        } catch {
            print("Ошибка при сохранении: \(error)")
        }
    }
    
    func deleteAllPlants() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Plant.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try viewContext.execute(deleteRequest)
            try viewContext.save()
            fetchPlants() // Refresh list
        } catch {
            print("Ошибка при удалении всех растений: \(error)")
        }
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
