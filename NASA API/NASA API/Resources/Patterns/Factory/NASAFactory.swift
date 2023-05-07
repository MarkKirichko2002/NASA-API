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
        // MARK: - категории изображений
        
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
        // MARK: - экраны NASA
        
        // ViewModel Image Categories
        container.register(NASAImageCategoriesListViewViewModel.self) { resolver in
            let viewModel = NASAImageCategoriesListViewViewModel(nasaService: resolver.resolve(NASAServiceProtocol.self), epicNASAImagesListViewViewModel: resolver.resolve(EPICNASAImagesListViewViewModel.self))
            return viewModel
        }
        
        // ViewModel Asteroid
        container.register(AsteroidsViewModel.self) { resolver in
            let viewModel = AsteroidsViewModel(nasaService: resolver.resolve(NASAServiceProtocol.self))
            return viewModel
        }
        // ViewModel Video Library
        container.register(NASAVideoLibraryListViewViewModel.self) { resolver in
            let viewModel = NASAVideoLibraryListViewViewModel(nasaService: resolver.resolve(NASAServiceProtocol.self))
            return viewModel
        }
        // Mars Weather Presenter
        container.register(MarsWeatherPresenter.self) { resolver in
            let presenter = MarsWeatherPresenter(nasaService: resolver.resolve(NASAServiceProtocol.self))
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
            let vc = MarsPhotosViewController()
            vc.title = "Фото Марса"
            vc.navigationItem.largeTitleDisplayMode = .never
            return vc
        case .nasaimages:
            let vc = NASAImageLibraryViewController()
            vc.title = "NASA изображения"
            vc.navigationItem.largeTitleDisplayMode = .never
            return vc
        case .epic:
            let vc = EPICNASAImagesViewController()
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
    
    func createNASAScreens(screen: NASAScreens)-> UIViewController {
        switch screen {
        case .imagecategories:
            let vc = NASAImageCategoriesListViewController()
            vc.navigationItem.largeTitleDisplayMode = .automatic
            vc.tabBarItem = UITabBarItem(title: "Изображения", image: UIImage(named: "images"), selectedImage: UIImage(named: "images selected"))
            return vc
        case .asteroids:
            let vc = AsteroidsViewController(viewModel: container.resolve(AsteroidsViewModel.self))
            vc.navigationItem.largeTitleDisplayMode = .automatic
            vc.tabBarItem = UITabBarItem(title: "Астероиды", image: UIImage(named: "asteroids"), selectedImage: UIImage(named: "asteroids selected"))
            return vc
        case .videolibrary:
            let vc = NASAVideoLibraryViewController()
            vc.navigationItem.largeTitleDisplayMode = .automatic
            vc.tabBarItem = UITabBarItem(title: "NASA Видеотека", image: UIImage(named: "video player"), selectedImage: UIImage(named: "video player selected"))
            return vc
        case .marsweather:
            let vc = MarsWeatherViewController(presenter: container.resolve(MarsWeatherPresenter.self))
            vc.navigationItem.largeTitleDisplayMode = .automatic
            vc.tabBarItem = UITabBarItem(title: "Марс Погода", image: UIImage(systemName: "cloud"), selectedImage: UIImage(systemName: "cloud.fill"))
            return vc
        }
    }
    
    func createNASAVideoLibraryView(viewController: UIViewController & AnyObject)-> UIView {
        let view = NASAVideoLibraryListView(frame: .zero, viewModel: container.resolve(NASAVideoLibraryListViewViewModel.self))
        view.delegate = viewController as? any NASAVideoLibraryListViewDelegate
        return view
    }
}
