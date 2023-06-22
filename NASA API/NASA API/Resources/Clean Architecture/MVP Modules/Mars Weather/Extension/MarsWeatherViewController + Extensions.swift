//
//  MarsWeatherViewController + Extensions.swift
//  NASA API
//
//  Created by Марк Киричко on 22.06.2023.
//

import Foundation

// MARK: - MarsWeatherPresenterDelegate
extension MarsWeatherViewController: MarsWeatherPresenterDelegate {
    
    func displayMarsWeather(weather: ValidityChecks) {
        WeatherLabel.text = "Sol Hours Required: \(weather.solHoursRequired)"
    }
}
