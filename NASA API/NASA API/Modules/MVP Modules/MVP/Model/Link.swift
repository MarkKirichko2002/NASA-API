//
//  Link.swift
//  NASA API
//
//  Created by Марк Киричко on 24.01.2023.
//

import Foundation

// MARK: - Link
struct Link: Codable {
    let href: String
    let rel: String
    let render: String?
}
