//
//  PlantInput.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 12.05.2025.
//

import Foundation

struct PlantInput: Codable {
    let images: [String]
    let datetime: String
    let latitude: Double?
    let longitude: Double?
    let similarImages: Bool?

    enum CodingKeys: String, CodingKey {
        case images, datetime, latitude, longitude
        case similarImages = "similar_images"
    }
}
