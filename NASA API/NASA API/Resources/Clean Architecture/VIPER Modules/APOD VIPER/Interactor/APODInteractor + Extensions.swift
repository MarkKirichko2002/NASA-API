//
//  APODInteractor + Extensions.swift
//  NASA API
//
//  Created by Марк Киричко on 22.06.2023.
//

import Foundation

// MARK: - APODInteractorProtocol
extension APODInteractor: APODInteractorProtocol {
    
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
