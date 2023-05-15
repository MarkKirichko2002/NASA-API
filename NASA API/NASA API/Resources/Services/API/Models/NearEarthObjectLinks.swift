//
//  NearEarthObjectLinks.swift
//  NASA API
//
//  Created by Марк Киричко on 12.03.2023.
//

import Foundation

// MARK: - NearEarthObjectLinks
struct NearEarthObjectLinks: Codable {
    let linksSelf: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}
