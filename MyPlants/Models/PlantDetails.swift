//
//  PlantDetails.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 12.05.2025.
//

import Foundation

struct PlantDetails: Codable {
    let commonNames: [String]?
    let taxonomy: Taxonomy?
    let url: String?
    let gbifID: Int?
    let inaturalistID: Int?
    let rank: String?
    let description: Description?
    let synonyms: [String]?
    let image: PlantImage?
    let language: String?
    let entityID: String?

    enum CodingKeys: String, CodingKey {
        case commonNames = "common_names"
        case taxonomy, url
        case gbifID = "gbif_id"
        case inaturalistID = "inaturalist_id"
        case rank, description, synonyms, image, language
        case entityID = "entity_id"
    }
}
