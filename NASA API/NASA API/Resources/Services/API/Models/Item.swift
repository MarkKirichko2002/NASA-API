//
//  Item.swift
//  NASA API
//
//  Created by Марк Киричко on 24.01.2023.
//

import Foundation

// MARK: - Item
struct Item: Codable {
    let href: String
    let data: [LibraryData]
    let links: [Link]
}
