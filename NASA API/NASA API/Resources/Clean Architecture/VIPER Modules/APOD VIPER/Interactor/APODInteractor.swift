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

class APODInteractor {
    
    weak var presenter: APODPresenterProtocol?
    
    var nasaService: NASAServiceProtocol?
    
    // MARK: - Init
    init(nasaService: NASAServiceProtocol?) {
        self.nasaService = nasaService
    }
}
