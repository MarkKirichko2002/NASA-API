//
//  Collection.swift
//  NASA API
//
//  Created by Марк Киричко on 24.01.2023.
//

import Foundation

// MARK: - Collection
struct Collection: Codable {
    let version: String
    let href: String
    let items: [Item]
    let metadata: Metadata
}
