//
//  NearEarthObject.swift
//  NASA API
//
//  Created by Марк Киричко on 12.03.2023.
//

import Foundation

// MARK: - NearEarthObject
class NearEarthObject: NSObject, Codable {
    let links: NearEarthObjectLinks
    let id, neoReferenceID, name: String
    let nasaJplURL: String
    let absoluteMagnitudeH: Double
    let estimatedDiameter: EstimatedDiameter
    let isPotentiallyHazardousAsteroid: Bool
    let closeApproachData: [CloseApproachDatum]
    let isSentryObject: Bool

    enum CodingKeys: String, CodingKey {
        case links, id
        case neoReferenceID = "neo_reference_id"
        case name
        case nasaJplURL = "nasa_jpl_url"
        case absoluteMagnitudeH = "absolute_magnitude_h"
        case estimatedDiameter = "estimated_diameter"
        case isPotentiallyHazardousAsteroid = "is_potentially_hazardous_asteroid"
        case closeApproachData = "close_approach_data"
        case isSentryObject = "is_sentry_object"
    }

    init(
        links: NearEarthObjectLinks,
         id: String,
         neoReferenceID: String,
         name: String,
         nasaJplURL: String,
         absoluteMagnitudeH: Double,
         estimatedDiameter: EstimatedDiameter,
         isPotentiallyHazardousAsteroid: Bool,
         closeApproachData: [CloseApproachDatum],
         isSentryObject: Bool
    ) {
        self.links = links
        self.id = id
        self.neoReferenceID = neoReferenceID
        self.name = name
        self.nasaJplURL = nasaJplURL
        self.absoluteMagnitudeH = absoluteMagnitudeH
        self.estimatedDiameter = estimatedDiameter
        self.isPotentiallyHazardousAsteroid = isPotentiallyHazardousAsteroid
        self.closeApproachData = closeApproachData
        self.isSentryObject = isSentryObject
    }
}
