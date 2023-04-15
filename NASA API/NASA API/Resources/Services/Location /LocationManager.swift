//
//  LocationManager.swift
//  NASA API
//
//  Created by Марк Киричко on 15.04.2023.
//

import CoreLocation

class LocationManager {
    
    private let locationManager = CLLocationManager()
    private var currentLoc: CLLocation?
    
    func GetCurrentLocation()-> LocationViewModel {
        locationManager.requestWhenInUseAuthorization()
        currentLoc = locationManager.location
        let location = LocationViewModel(latitude: currentLoc?.coordinate.latitude ?? 0.0, longitude: currentLoc?.coordinate.longitude ?? 0.0)
        return location
    }
}
