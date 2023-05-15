//
//  At.swift
//  NASA API
//
//  Created by Марк Киричко on 04.02.2023.
//

import Foundation

// MARK: - At
struct At: Codable {
    let solHoursWithData: [Int]
    let valid: Bool

    enum CodingKeys: String, CodingKey {
        case solHoursWithData = "sol_hours_with_data"
        case valid
    }
}
