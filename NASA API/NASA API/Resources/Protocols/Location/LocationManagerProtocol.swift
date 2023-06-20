//
//  LocationManagerProtocol.swift
//  NASA API
//
//  Created by Марк Киричко on 20.06.2023.
//

import Foundation

protocol LocationManagerProtocol {
    func GetCurrentLocation()-> LocationViewModel
}
