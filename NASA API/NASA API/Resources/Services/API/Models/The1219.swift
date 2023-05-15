//
//  The1219.swift
//  NASA API
//
//  Created by Марк Киричко on 04.02.2023.
//

import Foundation

// MARK: - The1219
struct The1219: Codable {
    let at, hws, pre, wd: At

    enum CodingKeys: String, CodingKey {
        case at = "AT"
        case hws = "HWS"
        case pre = "PRE"
        case wd = "WD"
    }
}
