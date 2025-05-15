//
//  NetworkService.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 12.05.2025.
//

import Foundation
import SwiftUI

final class PlantIDService: PlantIDServiceProtocol {
    private let apiKey = "l5bdcL6et21Dxe4zOYcjWlpX14Ph4ferGJ3KfZAGB9cVOZhtD1"

    func identify(image: UIImage) async throws -> PlantIDResponse {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            throw IdentificationError.invalidImage
        }

        let base64Image = imageData.base64EncodedString()

        var urlComponents = URLComponents(string: "https://api.plant.id/v3/identification")!
        urlComponents.queryItems = [
            URLQueryItem(name: "details", value: "description,taxonomy,common_names"),
            URLQueryItem(name: "language", value: "en")
        ]

        guard let url = urlComponents.url else {
            throw IdentificationError.badServerResponse
        }

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

        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            print("Status Code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
            print("Response body: \(String(data: data, encoding: .utf8) ?? "N/A")")
            throw IdentificationError.badServerResponse
        }

        do {
            return try JSONDecoder().decode(PlantIDResponse.self, from: data)
        } catch {
            print("Decoding failed: \(error)")
            throw IdentificationError.decodingFailed
        }
    }
}

enum IdentificationError: Error, LocalizedError {
    case invalidImage
    case badServerResponse
    case decodingFailed

    var errorDescription: String? {
        switch self {
        case .invalidImage:
            return "Unfortunately, it was not possible to recognize your plant or its disease"
        case .badServerResponse:
            return "Bad server responce"
        case .decodingFailed:
            return "Failed to decode"
        }
    }
}
