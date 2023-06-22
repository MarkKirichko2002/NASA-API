//
//  EarthInteractor.swift
//  Super easy dev
//
//  Created by Марк Киричко on 16.05.2023
//

protocol EarthInteractorProtocol: AnyObject {
     func GetEarthImage()
}

class EarthInteractor {
    
    weak var presenter: EarthPresenterProtocol?
    
    var nasaService: NASAServiceProtocol?
    
    // MARK: - Init
    init(nasaService: NASAServiceProtocol?) {
        self.nasaService = nasaService
    }
}
