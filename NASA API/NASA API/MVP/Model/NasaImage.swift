//
//  Nasa.swift
//  NASA API
//
//  Created by Марк Киричко on 10.08.2022.
//

import Foundation


// MARK: - MarsImage
struct MarsImage: Codable {
    let photos: [Photo]
}

// MARK: - Photo
struct Photo: Codable {
    let id, sol: Int
    let camera: Camera
    let imgSrc: String
    let earthDate: String
    let rover: Rover

    enum CodingKeys: String, CodingKey {
        case id, sol, camera
        case imgSrc = "img_src"
        case earthDate = "earth_date"
        case rover
    }
}

// MARK: - Camera
struct Camera: Codable {
    let id: Int
    let name: String
    let roverID: Int
    let fullName: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case roverID = "rover_id"
        case fullName = "full_name"
    }
}

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

// MARK: - NASAImages
struct NASAImages: Codable {
    let collection: Collection
}

// MARK: - Collection
struct Collection: Codable {
    let version: String
    let href: String
    let items: [Item]
    let metadata: Metadata
}

// MARK: - Item
struct Item: Codable {
    let href: String
    let data: [ImageData]
    let links: [Link]
}

// MARK: - ImageData
struct ImageData: Codable {
    let center: String
    let title, nasaID: String
    let dateCreated: String
    let mediaType: String
    let dataDescription: String
    let keywords, album: [String]?
    let location, description508, secondaryCreator: String?

    enum CodingKeys: String, CodingKey {
        case center, title
        case nasaID = "nasa_id"
        case dateCreated = "date_created"
        case mediaType = "media_type"
        case dataDescription = "description"
        case keywords, album, location
        case description508 = "description_508"
        case secondaryCreator = "secondary_creator"
    }
}


// MARK: - Link
struct Link: Codable {
    let href: String
    let rel: String
    let render: String
}

// MARK: - Metadata
struct Metadata: Codable {
    let totalHits: Int

    enum CodingKeys: String, CodingKey {
        case totalHits = "total_hits"
    }
}

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

// MARK: - AttitudeQuaternions
struct AttitudeQuaternions: Codable {
    let q0, q1, q2, q3: Double
}

// MARK: - CentroidCoordinates
struct CentroidCoordinates: Codable {
    let lat, lon: Double
}

// MARK: - Coords
struct Coords: Codable {
    let centroidCoordinates: CentroidCoordinates
    let dscovrJ2000Position, lunarJ2000Position, sunJ2000Position: J2000Position
    let attitudeQuaternions: AttitudeQuaternions

    enum CodingKeys: String, CodingKey {
        case centroidCoordinates = "centroid_coordinates"
        case dscovrJ2000Position = "dscovr_j2000_position"
        case lunarJ2000Position = "lunar_j2000_position"
        case sunJ2000Position = "sun_j2000_position"
        case attitudeQuaternions = "attitude_quaternions"
    }
}

// MARK: - J2000Position
struct J2000Position: Codable {
    let x, y, z: Double
}

