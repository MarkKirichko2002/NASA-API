//
//  EPIC.swift
//  NASA API
//
//  Created by Марк Киричко on 24.01.2023.
//

import Foundation

// MARK: - EPIC
struct EPIC: Codable {
    var identifier, caption, image, version: String
    let centroidCoordinates: CentroidCoordinates
    let dscovrJ2000Position, lunarJ2000Position, sunJ2000Position: J2000Position
    let attitudeQuaternions: AttitudeQuaternions
    let date: String
    let coords: Coords

    enum CodingKeys: String, CodingKey {
        case identifier, caption, image, version
        case centroidCoordinates = "centroid_coordinates"
        case dscovrJ2000Position = "dscovr_j2000_position"
        case lunarJ2000Position = "lunar_j2000_position"
        case sunJ2000Position = "sun_j2000_position"
        case attitudeQuaternions = "attitude_quaternions"
        case date, coords
    }
}

