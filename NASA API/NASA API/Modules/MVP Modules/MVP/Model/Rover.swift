//
//  Rover.swift
//  NASA API
//
//  Created by Марк Киричко on 24.01.2023.
//

import Foundation

// MARK: - Rover
struct Rover: Codable {
    let id: Int
    let name: String
    let landingDate, launchDate: String
    let status: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case landingDate = "landing_date"
        case launchDate = "launch_date"
        case status
    }
}
