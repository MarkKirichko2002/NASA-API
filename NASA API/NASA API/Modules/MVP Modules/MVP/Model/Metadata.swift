//
//  Metadata.swift
//  NASA API
//
//  Created by Марк Киричко on 24.01.2023.
//

import Foundation

// MARK: - Metadata
struct Metadata: Codable {
    let totalHits: Int

    enum CodingKeys: String, CodingKey {
        case totalHits = "total_hits"
    }
}
