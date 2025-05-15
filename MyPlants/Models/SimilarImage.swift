//
//  SimilarImage.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 12.05.2025.
//

import Foundation

struct SimilarImage: Codable, Equatable {
    let id: String
    let url: String
    let licenseName: String?
    let licenseURL: String?
    let citation: String?
    let similarity: Double?
    let urlSmall: String?

    enum CodingKeys: String, CodingKey {
        case id, url, citation, similarity
        case licenseName = "license_name"
        case licenseURL = "license_url"
        case urlSmall = "url_small"
    }
}
