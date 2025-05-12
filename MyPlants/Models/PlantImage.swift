//
//  PlantImage.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 12.05.2025.
//

import Foundation

struct PlantImage: Codable {
    let value: String
    let citation: String?
    let licenseName: String?
    let licenseURL: String?

    enum CodingKeys: String, CodingKey {
        case value, citation
        case licenseName = "license_name"
        case licenseURL = "license_url"
    }
}
