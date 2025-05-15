//
//  PlantResult.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 12.05.2025.
//

import Foundation

struct PlantResult: Codable, Equatable {
    let isPlant: IsPlant?
    let classification: Classification

    enum CodingKeys: String, CodingKey {
        case isPlant = "is_plant"
        case classification
    }
}

