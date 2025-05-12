//
//  Suggestion.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 12.05.2025.
//

import Foundation


struct Suggestion: Codable {
    let id: String
    let name: String
    let source: String
    let probability: Double
    let similarImages: [SimilarImage]?
    let details: PlantDetails
}
