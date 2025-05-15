//
//  PlantInput.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 12.05.2025.
//

import Foundation

struct PlantInput: Codable, Equatable {
    let latitude: Double
    let longitude: Double
    let similarImages: Bool
    let images: [String]
    let datetime: String

    enum CodingKeys: String, CodingKey {
        case latitude, longitude, images, datetime
        case similarImages = "similar_images"
    }
}
