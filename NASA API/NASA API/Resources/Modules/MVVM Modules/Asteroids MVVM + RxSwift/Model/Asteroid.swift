//
//  Asteroid.swift
//  NASA API
//
//  Created by Марк Киричко on 26.08.2022.
//

import Foundation

// MARK: - Asteroid
struct Asteroid: Codable {
    let links: AsteroidLinks?
    let elementCount: Int?
    let nearEarthObjects: [String: [NearEarthObject]]?

    enum CodingKeys: String, CodingKey {
        case links
        case elementCount = "element_count"
        case nearEarthObjects = "near_earth_objects"
    }
}
