//
//  PlantIDResponse.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 12.05.2025.
//

import Foundation

struct PlantIDResponse: Codable, Equatable {
    let accessToken: String
    let modelVersion: String
    let input: PlantInput
    let result: PlantResult
    let status: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case modelVersion = "model_version"
        case input, result, status
    }
}
