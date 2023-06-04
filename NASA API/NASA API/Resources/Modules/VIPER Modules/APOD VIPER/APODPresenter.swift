//
//  APODPresenter.swift
//  Super easy dev
//
//  Created by Марк Киричко on 15.05.2023
//

import UIKit

protocol APODPresenterProtocol: AnyObject {
    func recognizeText(image: UIImage)
    func interactorDidFetchedAPOD(apod: Apod)
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
    
    func recognizeText(image: UIImage) {
        textRecognitionManager.recognizeText(image: image) { text in
            self.interactor.recognizeText(text: text)
        }
    }
    
    func interactorDidFetchedAPOD(apod: Apod) {
        view?.displayAPOD(apod: apod)
    }
}
