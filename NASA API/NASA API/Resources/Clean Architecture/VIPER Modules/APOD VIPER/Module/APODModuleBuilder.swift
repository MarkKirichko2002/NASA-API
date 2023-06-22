//
//  APODModuleBuilder.swift
//  Super easy dev
//
//  Created by Марк Киричко on 15.05.2023
//

import UIKit

class APODModuleBuilder {
    static func build(nasaService: NASAServiceProtocol?) -> APODViewController {
        let interactor = APODInteractor(nasaService: nasaService)
        let router = APODRouter()
        let presenter = APODPresenter(interactor: interactor, router: router)
        let viewController = APODViewController()
        presenter.view = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
