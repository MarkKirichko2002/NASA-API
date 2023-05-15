//
//  MissDistance.swift
//  NASA API
//
//  Created by Марк Киричко on 12.03.2023.
//

import Foundation

// MARK: - MissDistance
struct MissDistance: Codable {
    let astronomical, lunar, kilometers, miles: String
}
