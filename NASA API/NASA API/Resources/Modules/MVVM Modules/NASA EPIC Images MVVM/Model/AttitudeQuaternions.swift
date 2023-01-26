//
//  AttitudeQuaternions.swift
//  NASA API
//
//  Created by Марк Киричко on 24.01.2023.
//

import Foundation

// MARK: - AttitudeQuaternions
struct AttitudeQuaternions: Codable {
    let q0, q1, q2, q3: Double
}
