//
//  MarsWeather.swift
//  NASA API
//
//  Created by Марк Киричко on 04.02.2023.
//

import Foundation

// MARK: - MarsWeather
struct MarsWeather: Codable {
    //let solKeys: [JSONAny]
    let validityChecks: ValidityChecks?

    enum CodingKeys: String, CodingKey {
        //case solKeys = "sol_keys"
        case validityChecks = "validity_checks"
    }
}
