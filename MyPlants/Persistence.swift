//
//  Persistence.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 08.05.2025.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    @MainActor
    let container: NSPersistentContainer
    
    static let preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        let context = controller.container.viewContext
        
        for i in 1...10 {
            let plant = Plant(context: context)
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
            plant.createdAt = Date().addingTimeInterval(Double(-i) * 86400)
        }
        
        do {
            try context.save()
        } catch {
            print("Ошибка создания предпросмотра: \(error)")
        }
        
        return controller
    }()
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "PlantModel")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
