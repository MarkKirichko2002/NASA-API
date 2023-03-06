//
//  APODPresenter.swift
//  NASA API
//
//  Created by Марк Киричко on 25.01.2023.
//

import UIKit

protocol APODPresentDelegate {
    func PresentAPOD(apod: Apod)
}

typealias APODPresenterType = APODPresentDelegate & UIViewController

class APODPresenter {
    
    var delegate: APODPresenterType?
    
    func GetAPOD() {
        NASAService.shared.execute(type: Apod.self, response: .apod) { [weak self] result in
            switch result {
            case .success(let data):
                self?.delegate?.PresentAPOD(apod: data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func SetViewDelegate(delegate: APODPresenterType) {
        self.delegate = delegate
    }
}
