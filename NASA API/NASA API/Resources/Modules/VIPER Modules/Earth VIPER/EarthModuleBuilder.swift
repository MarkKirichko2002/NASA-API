//
//  EarthModuleBuilder.swift
//  Super easy dev
//
//  Created by Марк Киричко on 16.05.2023
//

import UIKit

class EarthModuleBuilder {
    static func build(nasaService: NASAServiceProtocol?) -> EarthViewController {
        let interactor = EarthInteractor(nasaService: nasaService)
        let router = EarthRouter()
        let presenter = EarthPresenter(interactor: interactor, router: router)
        let viewController = EarthViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
