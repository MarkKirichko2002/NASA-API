//
//  EarthInteractor.swift
//  Super easy dev
//
//  Created by Марк Киричко on 16.05.2023
//

protocol EarthInteractorProtocol: AnyObject {
     func GetEarthImage()
}

class EarthInteractor: EarthInteractorProtocol {
    
    weak var presenter: EarthPresenterProtocol?
    
    private var nasaService: NASAServiceProtocol?
    
    // MARK: - Init
    init(nasaService: NASAServiceProtocol?) {
        self.nasaService = nasaService
    }
    
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
