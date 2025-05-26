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
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "PlantModel")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}

//dobavit init proverku

