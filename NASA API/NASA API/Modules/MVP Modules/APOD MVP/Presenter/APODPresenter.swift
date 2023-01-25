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
        APIManager.shared.fetchAPOD { apod in
            self.delegate?.PresentAPOD(apod: apod)
        }
    }
    
    func SetViewDelegate(delegate: APODPresenterType) {
        self.delegate = delegate
    }
}
