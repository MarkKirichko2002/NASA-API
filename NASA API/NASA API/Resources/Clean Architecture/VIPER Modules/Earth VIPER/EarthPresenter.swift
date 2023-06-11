//
//  EarthPresenter.swift
//  Super easy dev
//
//  Created by Марк Киричко on 16.05.2023
//

protocol EarthPresenterProtocol: AnyObject {
    func interactorDidFetchedEarth(earth: Earth)
}

class EarthPresenter {
    weak var view: EarthViewProtocol?
    var router: EarthRouterProtocol
    var interactor: EarthInteractorProtocol

    // MARK: - Init
    init(interactor: EarthInteractorProtocol, router: EarthRouterProtocol) {
        self.interactor = interactor
        self.interactor.GetEarthImage()
        self.router = router
    }
}

extension EarthPresenter: EarthPresenterProtocol {
    func interactorDidFetchedEarth(earth: Earth) {
        view?.PresentEarth(earth: earth)
    }
}
