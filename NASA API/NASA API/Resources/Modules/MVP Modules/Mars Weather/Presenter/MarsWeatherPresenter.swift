//
//  MarsWeatherPresenter.swift
//  NASA API
//
//  Created by Марк Киричко on 04.02.2023.
//

import UIKit

protocol MarsWeatherPresenterDelegate {
    func displayMarsWeather(weather: ValidityChecks)
}

typealias MarsWeatherPresenterType = MarsWeatherPresenterDelegate & UIViewController

class MarsWeatherPresenter {
    
    var delegate: MarsWeatherPresenterDelegate?
    
    func GetMarsWeather() {
        NASAService.shared.fetchMarsWeather { marsweather in
            self.delegate?.displayMarsWeather(weather: marsweather)
        }
    }
    
    func SetViewDelegate(delegate: MarsWeatherPresenterType) {
        self.delegate = delegate
    }
}
