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

final class MarsWeatherPresenter {
    
    var delegate: MarsWeatherPresenterDelegate?
    
    private var nasaService: NASAServiceProtocol?
    
    init(nasaService: NASAServiceProtocol?) {
        self.nasaService = nasaService
    }
    
    func GetMarsWeather() {
        nasaService?.execute(type: MarsWeather.self, response: .marsweather) { [weak self] result in
            switch result {
            case .success(let data):
                guard let data = data.validityChecks else {return}
                self?.delegate?.displayMarsWeather(weather: data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func SetViewDelegate(delegate: MarsWeatherPresenterType) {
        self.delegate = delegate
    }
}
