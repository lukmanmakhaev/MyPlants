//
//  IdentificationViewModel.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 12.05.2025.
//

import Foundation
import SwiftUI

@MainActor
final class IdentificationViewModel: ObservableObject {
    @Published var result: PlantIDResponse?
    @Published var isLoading = false
    @Published var error: String?
    @Published var showResult = false
    @Published var showIdentification = false
    @Published var showError = false


    private let service: PlantIDServiceProtocol

    init(service: PlantIDServiceProtocol = PlantIDService()) {
        self.service = service
    }

    func identify(image: UIImage) async {
        error = nil
        result = nil
        isLoading = true
        
        do {
            let result = try await service.identify(image: image)
            self.result = result
            self.showIdentification = true
            self.isLoading = false
        } catch {
            self.error = error.localizedDescription
            showError.toggle()
            self.isLoading = false
        }
    }
    
    func reset() {
        result = nil
        error = nil
        showResult = false
        showError = false
    }
}
