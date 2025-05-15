//
//  Suggestions+ext.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 13.05.2025.
//

import Foundation

extension Suggestion {
    func toPlantData() -> PlantData {
        
        let imageUrls = similarImages?
            .prefix(2)
            .compactMap { $0.url }
            ?? []
        
        return PlantData(
            name: name,
            commonName: details?.commonNames?.first ?? "",
            description: details?.description?.value ?? "",
            kingdom: details?.taxonomy?.kingdom ?? "",
            phylum: details?.taxonomy?.phylum ?? "",
            plantClass: details?.taxonomy?.class ?? "",
            probability: probability,
            order: details?.taxonomy?.order ?? "",
            family: details?.taxonomy?.family ?? "",
            genus: details?.taxonomy?.genus ?? "",
            imageUrls: imageUrls
        )
    }
}
