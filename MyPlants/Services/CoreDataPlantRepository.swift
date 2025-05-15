//
//  CoreDataPlantRepository.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 13.05.2025.
//

import Foundation
import CoreData


final class CoreDataPlantRepository: PlantRepository {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func addPlant(data: PlantData) {
        let plant = Plant(context: context)
        plant.id = UUID()
        plant.name = data.name
        plant.commonName = data.commonName
        plant.descriptionText = data.description
        plant.kingdom = data.kingdom
        plant.phylum = data.phylum
        plant.plantClass = data.plantClass
        plant.order = data.order
        plant.family = data.family
        plant.genus = data.genus
        plant.probability = data.probability
        plant.createdAt = Date()
        plant.imageUrls = data.imageUrls

        try? context.save()
    }

    func fetchAll() -> [Plant] {
        let request: NSFetchRequest<Plant> = Plant.fetchRequest()
        return (try? context.fetch(request)) ?? []
    }

    func delete(_ plant: Plant) {
        context.delete(plant)
        try? context.save()
    }

}
