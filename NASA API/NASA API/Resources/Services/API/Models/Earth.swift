//
//  Earth.swift
//  NASA API
//
//  Created by Марк Киричко on 15.04.2023.
//

import Foundation

// MARK: - Earth
struct Earth: Codable {
    let date, id: String?
    let resource: Resource?
    let serviceVersion: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case date, id, resource
        case serviceVersion = "service_version"
        case url
    }
}
