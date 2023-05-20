//
//  APODPresenter.swift
//  Super easy dev
//
//  Created by Марк Киричко on 15.05.2023
//

protocol APODPresenterProtocol: AnyObject {
    func interactorDidFetchedAPOD(apod: Apod)
}

class APODPresenter {
    weak var view: APODViewProtocol?
    var router: APODRouterProtocol
    var interactor: APODInteractorProtocol

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
}
