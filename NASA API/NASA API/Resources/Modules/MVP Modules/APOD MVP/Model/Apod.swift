//
//  Apod.swift
//  NASA API
//
//  Created by Марк Киричко on 25.01.2023.
//

import Foundation

// MARK: - Apod
struct Apod: Codable {
    let copyright, date, explanation: String?
    let hdurl: String?
    let mediaType, serviceVersion, title: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case copyright, date, explanation, hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title, url
    }
}
