//
//  AsteroidLinks.swift
//  NASA API
//
//  Created by Марк Киричко on 12.03.2023.
//

import Foundation

// MARK: - AsteroidLinks
struct AsteroidLinks: Codable {
    let next, prev, linksSelf: String?

    enum CodingKeys: String, CodingKey {
        case next, prev
        case linksSelf = "self"
    }
}
