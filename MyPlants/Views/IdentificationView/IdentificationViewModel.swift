//
//  IdentificationViewModel.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 12.05.2025.
//

import Foundation
import SwiftUI

final class IdentificationViewModel: ObservableObject {
    @Published var result: PlantIDResponse?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let apiKey = "lnhd6wKuwZpjZJcerE0PaM9fH5uGAv4awELYpJrCGl0ABpYsP6"
    
    func identifyPlant(from image: UIImage) async {
        isLoading = true
        errorMessage = nil
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            errorMessage = "Could not get the image data."
            isLoading = false
            return
        }
        
        let base64Image = imageData.base64EncodedString()
        let url = URL(string: "https://api.plant.id/v3/identification")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(apiKey, forHTTPHeaderField: "Api-Key")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "images": [base64Image],
            "similar_images": true,
            "latitude": 0,
            "longitude": 0
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw URLError(.badServerResponse)
            }
            
            let decoded = try JSONDecoder().decode(PlantIDResponse.self, from: data)
            self.result = decoded
            print(self.result ?? "---!---")
        } catch {
            self.errorMessage = "Ошибка: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
