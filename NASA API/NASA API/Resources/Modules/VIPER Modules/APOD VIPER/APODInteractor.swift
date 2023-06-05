//
//  APODInteractor.swift
//  Super easy dev
//
//  Created by Марк Киричко on 15.05.2023
//

protocol APODInteractorProtocol: AnyObject {
    func GetAPOD()
    func recognizeText(text: String)
    func fetchAPODWithOtherDate(date: String)
}

class APODInteractor: APODInteractorProtocol {
    
    weak var presenter: APODPresenterProtocol?
    
    private var nasaService: NASAServiceProtocol?
    
    // MARK: - Init
    init(nasaService: NASAServiceProtocol?) {
        self.nasaService = nasaService
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
    
    func recognizeText(text: String) {
        nasaService?.MakeAPICallWithOtherDate(type: Apod.self, response: .apod, date: text) { [weak self] result in
            switch result {
            case .success(let data):
                self?.presenter?.interactorDidFetchedAPOD(apod: data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchAPODWithOtherDate(date: String) {
        nasaService?.MakeAPICallWithOtherDate(type: Apod.self, response: .apod, date: date) { [weak self] result in
            switch result {
            case .success(let data):
                self?.presenter?.interactorDidFetchedAPOD(apod: data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
