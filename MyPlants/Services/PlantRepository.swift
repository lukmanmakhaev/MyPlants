//
//  PlantRepository.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 13.05.2025.
//

import Foundation

protocol PlantRepository {
    func addPlant(data: PlantData)
    func delete(_ plant: Plant)
    func fetchAll() -> [Plant]
}
