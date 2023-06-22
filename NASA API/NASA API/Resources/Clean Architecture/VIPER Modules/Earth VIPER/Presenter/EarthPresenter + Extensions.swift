//
//  EarthPresenter + Extensions.swift
//  NASA API
//
//  Created by Марк Киричко on 22.06.2023.
//

import Foundation

// MARK - EarthPresenterProtocol
extension EarthPresenter: EarthPresenterProtocol {
    
    func interactorDidFetchedEarth(earth: Earth) {
        view?.PresentEarth(earth: earth)
    }
}
