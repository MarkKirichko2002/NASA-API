//
//  APODInteractor.swift
//  Super easy dev
//
//  Created by Марк Киричко on 15.05.2023
//

protocol APODInteractorProtocol: AnyObject {
    func recognizeText(text: String)
    func GetAPOD()
}

class APODInteractor: APODInteractorProtocol {
    
    weak var presenter: APODPresenterProtocol?
    
    private var nasaService: NASAServiceProtocol?
    
    // MARK: - Init
    init(nasaService: NASAServiceProtocol?) {
        self.nasaService = nasaService
    }
    
    func recognizeText(text: String) {
        print(text)
        nasaService?.MakeAPICallWithOtherDate(type: Apod.self, response: .apod, date: text) { [weak self] result in
            switch result {
            case .success(let data):
                self?.presenter?.interactorDidFetchedAPOD(apod: data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func GetAPOD() {
        nasaService?.execute(type: Apod.self, response: .apod) { [weak self] result in
            switch result {
            case .success(let data):
                self?.presenter?.interactorDidFetchedAPOD(apod: data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
