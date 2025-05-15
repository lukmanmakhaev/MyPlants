//
//  PlantIDServiceProtocol.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 13.05.2025.
//

import Foundation
import SwiftUI

protocol PlantIDServiceProtocol {
    func identify(image: UIImage) async throws -> PlantIDResponse
}
