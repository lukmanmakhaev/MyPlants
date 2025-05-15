//
//  Taxonomy.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 12.05.2025.
//

import Foundation

struct Taxonomy: Codable, Equatable {
    let kingdom, phylum, order, family, genus, `class`: String?

    enum CodingKeys: String, CodingKey {
        case kingdom, phylum, order, family, genus
        case `class` = "class"
    }
}
