//
//  ViewMode.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 08.05.2025.
//

import Foundation
import CoreData
import SwiftUI

class HomeViewModel: ObservableObject {
    private let repository: PlantRepository
    @Published var plants: [Plant] = []
    
    @Published var showBanner = false
    @Published var bannerMessage = ""
    
    init(repository: PlantRepository) {
        self.repository = repository
        fetchPlants()
    }

    func fetchPlants() {
        plants = repository.fetchAll()
    }

    func saveToGarden(from suggestion: Suggestion) {
        bannerMessage = "Plant successfully added!"
        withAnimation {
            showBanner = true
        }
        
        let data = suggestion.toPlantData()
        repository.addPlant(data: data)
        fetchPlants()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation {
                self.showBanner = false
            }
        }
    }

    func deletePlant(_ plant: Plant) {
        bannerMessage = "Plant has been removed from My garden"
        withAnimation {
            showBanner = true
        }
        
        repository.delete(plant)
        fetchPlants()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation {
                self.showBanner = false
            }
        }
    }
    
    func contains(_ suggestion: Suggestion) -> Bool {
        plants.contains { $0.name == suggestion.name }
    }

    func togglePlant(from suggestion: Suggestion, inputImageUrl: String) {
        if let existing = plants.first(where: { $0.name == suggestion.name }) {
            deletePlant(existing)
        } else {
            var data = suggestion.toPlantData()
            data.imageUrls.insert(inputImageUrl, at: 0)
            repository.addPlant(data: data)
            fetchPlants()
            
            bannerMessage = "Plant successfully added!"
            withAnimation {
                showBanner = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.showBanner = false
                }
            }
        }
    }
}
