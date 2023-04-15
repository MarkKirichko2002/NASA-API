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

class EarthPresenter {
    
    var delegate: EarthPresenterType?
    
    func GetEarthImage() {
        NASAService.shared.execute(type: Earth.self, response: .earth) { [weak self] result in
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
