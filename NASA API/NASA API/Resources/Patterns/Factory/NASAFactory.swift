//
//  NASAFactory.swift
//  NASA API
//
//  Created by Марк Киричко on 07.05.2023.
//

import UIKit
import Swinject

final class NASAScreenFactory: NASAScreenFactoryProtocol {
    
    private let container: Container = {
        let container = Container()
        // API
        container.register(NASAServiceProtocol.self) { _ in
            return NASAService()
        }
        // ViewModel Image Categories
        container.register(NASAImageCategoriesListViewViewModel.self) { resolver in
            let viewModel = NASAImageCategoriesListViewViewModel(nasaService: resolver.resolve(NASAServiceProtocol.self), epicNASAImagesListViewViewModel: resolver.resolve(EPICNASAImagesListViewViewModel.self))
            return viewModel
        }
        // APOD Presenter
        container.register(APODPresenter.self) { resolver in
            let presenter = APODPresenter(nasaService: resolver.resolve(NASAServiceProtocol.self))
            return presenter
        }
        // ViewModel Mars Photos
        container.register(MarsPhotosListViewViewModel.self) { resolver in
            let viewModel = MarsPhotosListViewViewModel(nasaService: resolver.resolve(NASAServiceProtocol.self))
            return viewModel
        }
        // ViewModel NASA Images
        container.register(NASAImageLibraryListViewViewModel.self) { resolver in
            let viewModel = NASAImageLibraryListViewViewModel(nasaService: resolver.resolve(NASAServiceProtocol.self))
            return viewModel
        }
        // ViewModel EPIC
        container.register(EPICNASAImagesListViewViewModel.self) { resolver in
            let viewModel = EPICNASAImagesListViewViewModel(nasaService: resolver.resolve(NASAServiceProtocol.self))
            return viewModel
        }
        // Earth Presenter
        container.register(EarthPresenter.self) { resolver in
            let presenter = EarthPresenter(nasaService: resolver.resolve(NASAServiceProtocol.self))
            return presenter
        }
        return container
    }()
    
    func createNASAImageCategoriesViews(view: ImageCategoriesView, viewController: UIViewController & AnyObject)-> UIView {
        switch view {
        case .imagecategories:
            let view = NASAImageCategoriesListView(frame: .zero, viewModel: container.resolve(NASAImageCategoriesListViewViewModel.self))
            view.delegate = viewController as? any NASAImageCategoriesListViewDelegate
            return view
        case .marsphotos:
            let view = MarsPhotosListView(frame: .zero, viewModel: container.resolve(MarsPhotosListViewViewModel.self))
            view.delegate = viewController as? any MarsPhotosListViewDelegate
            return view
        case .nasaimages:
            let view = NASAImageLibraryListView(frame: .zero, viewModel: container.resolve(NASAImageLibraryListViewViewModel.self))
            view.delegate = viewController as? any NASAImageLibraryListViewDelegate
            return view
        case .epic:
            let view = EPICNASAImagesListView(frame: .zero, viewModel: container.resolve(EPICNASAImagesListViewViewModel.self))
            view.delegate = viewController as? any EPICNASAImagesListViewDelegate
            return view
        }
    }
    
    func createImageCategoriesScreens(screen: ImageCategoriesScreen) -> UIViewController {
        switch screen {
        case .apod:
            let vc = APODViewController(presenter: container.resolve(APODPresenter.self))
            vc.title = "APOD"
            vc.navigationItem.largeTitleDisplayMode = .never
            return vc
        case .marsphotos:
            let vc = MarsPhotosViewController(viewModel: container.resolve(MarsPhotosListViewViewModel.self))
            vc.title = "Mars Photos"
            vc.navigationItem.largeTitleDisplayMode = .never
            return vc
        case .nasaimages:
            let vc = NASAImageLibraryViewController(viewModel: container.resolve(NASAImageLibraryListViewViewModel.self))
            vc.title = "NASA изображения"
            vc.navigationItem.largeTitleDisplayMode = .never
            return vc
        case .epic:
            let vc = EPICNASAImagesViewController(viewModel: container.resolve(EPICNASAImagesListViewViewModel.self))
            vc.title = "EPIC"
            vc.navigationItem.largeTitleDisplayMode = .never
            return vc
        case .earth:
            let vc = EarthViewController(presenter: container.resolve(EarthPresenter.self))
            vc.title = "Земля"
            vc.navigationItem.largeTitleDisplayMode = .never
            return vc
        }
    }
}
