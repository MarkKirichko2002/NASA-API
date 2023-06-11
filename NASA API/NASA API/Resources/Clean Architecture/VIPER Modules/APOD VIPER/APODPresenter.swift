//
//  APODPresenter.swift
//  Super easy dev
//
//  Created by Марк Киричко on 15.05.2023
//

import UIKit

protocol APODPresenterProtocol: AnyObject {
    func interactorDidFetchedAPOD(apod: Apod)
    func recognizeText(image: UIImage)
    func getAPODWithOtherDate(date: String)
}

class APODPresenter {
    weak var view: APODViewProtocol?
    var router: APODRouterProtocol
    var interactor: APODInteractorProtocol
    
    private var textRecognitionManager = TextRecognitionManager()

    // MARK: - Init
    init(interactor: APODInteractorProtocol, router: APODRouterProtocol) {
        self.interactor = interactor
        self.interactor.GetAPOD()
        self.router = router
    }
}

extension APODPresenter: APODPresenterProtocol {
    
    func interactorDidFetchedAPOD(apod: Apod) {
        view?.displayAPOD(apod: apod)
    }
    
    func recognizeText(image: UIImage) {
        textRecognitionManager.recognizeText(image: image) { text in
            self.interactor.recognizeText(text: text)
        }
    }
    
    func getAPODWithOtherDate(date: String) {
        interactor.fetchAPODWithOtherDate(date: date)
    }
}
