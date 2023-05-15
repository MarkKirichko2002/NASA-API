//
//  ValidityChecks.swift
//  NASA API
//
//  Created by Марк Киричко on 04.02.2023.
//

import Foundation

// MARK: - ValidityChecks
struct ValidityChecks: Codable {
    let the1219: The1219
    let solHoursRequired: Int
    let solsChecked: [String]

    enum CodingKeys: String, CodingKey {
        case the1219 = "1219"
        case solHoursRequired = "sol_hours_required"
        case solsChecked = "sols_checked"
    }
}
