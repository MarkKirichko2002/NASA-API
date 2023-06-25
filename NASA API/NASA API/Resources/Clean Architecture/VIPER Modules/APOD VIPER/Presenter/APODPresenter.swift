//
//  APODPresenter.swift
//  Super easy dev
//
//  Created by Марк Киричко on 15.05.2023
//

import UIKit

protocol APODPresenterProtocol: AnyObject {
    func getAPOD()
    func interactorDidFetchedAPOD(apod: Apod)
    func openCalendar()
    func recognizeText(image: UIImage)
    func getAPODWithOtherDate(date: String)
}

class APODPresenter {
    
    weak var view: APODViewProtocol?
    var router: APODRouterProtocol
    var interactor: APODInteractorProtocol
    
    var textRecognitionManager = TextRecognitionManager()

    // MARK: - Init
    init(interactor: APODInteractorProtocol, router: APODRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func getAPOD() {
        interactor.GetAPOD()
    }
    
    func openCalendar() {
        router.openCalendar()
    }
}
