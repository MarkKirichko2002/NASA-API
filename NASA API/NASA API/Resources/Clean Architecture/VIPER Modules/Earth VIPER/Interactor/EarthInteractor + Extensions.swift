//
//  EarthInteractor + Extensions.swift
//  NASA API
//
//  Created by Марк Киричко on 22.06.2023.
//

import Foundation

// MARK: - EarthInteractorProtocol
extension EarthInteractor: EarthInteractorProtocol {
    
    func GetEarthImage() {
        nasaService?.execute(type: Earth.self, response: .earth) { [weak self] result in
            switch result {
            case .success(let data):
                self?.presenter?.interactorDidFetchedEarth(earth: data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
