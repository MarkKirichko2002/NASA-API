//
//  Feet.swift
//  NASA API
//
//  Created by Марк Киричко on 12.03.2023.
//

import Foundation

// MARK: - Feet
struct Feet: Codable {
    let estimatedDiameterMin, estimatedDiameterMax: Double

    enum CodingKeys: String, CodingKey {
        case estimatedDiameterMin = "estimated_diameter_min"
        case estimatedDiameterMax = "estimated_diameter_max"
    }
}
