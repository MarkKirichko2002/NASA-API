//
//  EarthPresenter.swift
//  NASA API
//
//  Created by Марк Киричко on 15.04.2023.
//

import UIKit

protocol EarthPresentDelegate {
    func PresentEarth(earth: Earth)
}

typealias EarthPresenterType = EarthPresentDelegate & UIViewController

final class EarthPresenter {
    
    var delegate: EarthPresenterType?
    
    private var nasaService: NASAServiceProtocol?
    
    init(nasaService: NASAServiceProtocol?) {
        self.nasaService = nasaService
    }
    
    func GetEarthImage() {
        nasaService?.execute(type: Earth.self, response: .earth) { [weak self] result in
            switch result {
            case .success(let data):
                self?.delegate?.PresentEarth(earth: data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func SetViewDelegate(delegate: EarthPresenterType) {
        self.delegate = delegate
    }
}
