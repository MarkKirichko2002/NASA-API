//
//  NASAFactory.swift
//  NASA API
//
//  Created by Марк Киричко on 07.05.2023.
//

import UIKit

final class NASAScreenFactory: NASAScreenFactoryProtocol {
    
    func createNASAImageCategoriesViews(view: ImageCategoriesView, viewController: UIViewController & AnyObject)-> UIView {
        switch view {
        case .imagecategories:
            let view = NASAImageCategoriesListView(
                frame: .zero,
                viewModel: Injection.shared.makeContainer().resolve(NASAImageCategoriesListViewViewModel.self)
            )
            view.delegate = viewController as? any NASAImageCategoriesListViewDelegate
            return view
        case .marsphotos:
            let view = MarsPhotosListView(
                frame: .zero, viewModel: Injection.shared.makeContainer().resolve(MarsPhotosListViewViewModel.self)
            )
            view.delegate = viewController as? any MarsPhotosListViewDelegate
            return view
        case .nasaimages:
            let view = NASAImageLibraryListView(
                frame: .zero, viewModel: Injection.shared.makeContainer().resolve(NASAImageLibraryListViewViewModel.self)
            )
            view.delegate = viewController as? any NASAImageLibraryListViewDelegate
            return view
        case .epic:
            let view = EPICNASAImagesListView(
                frame: .zero, viewModel: Injection.shared.makeContainer().resolve(EPICNASAImagesListViewViewModel.self)
            )
            view.delegate = viewController as? any EPICNASAImagesListViewDelegate
            return view
        }
    }
    
    func createImageCategoriesScreens(screen: ImageCategoriesScreen) -> UIViewController {
        switch screen {
        case .apod:
            let vc = APODModuleBuilder.build(
                nasaService: Injection.shared.makeContainer().resolve(NASAServiceProtocol.self)
            )
            vc.title = "APOD"
            vc.navigationItem.largeTitleDisplayMode = .never
            return vc
        case .marsphotos:
            let vc = MarsPhotosViewController(
                factory: Injection.shared.makeContainer().resolve(NASAScreenFactoryProtocol.self)
            )
            vc.title = "Фото Марса"
            vc.navigationItem.largeTitleDisplayMode = .never
            return vc
        case .nasaimages:
            let vc = NASAImageLibraryViewController(
                factory: Injection.shared.makeContainer().resolve(NASAScreenFactoryProtocol.self)
            )
            vc.title = "NASA изображения"
            vc.navigationItem.largeTitleDisplayMode = .never
            return vc
        case .epic:
            let vc = EPICNASAImagesViewController(
                factory: Injection.shared.makeContainer().resolve(NASAScreenFactoryProtocol.self)
            )
            vc.title = "EPIC"
            vc.navigationItem.largeTitleDisplayMode = .never
            return vc
        case .earth:
            let vc = EarthModuleBuilder.build(
                nasaService: Injection.shared.makeContainer().resolve(NASAServiceProtocol.self)
            )
            vc.title = "Земля"
            vc.navigationItem.largeTitleDisplayMode = .never
            return vc
        }
    }
    
    func createNASAScreens(screen: NASAScreens)-> UIViewController {
        switch screen {
        case .imagecategories:
            let vc = NASAImageCategoriesListViewController(
                factory: Injection.shared.makeContainer().resolve(NASAScreenFactoryProtocol.self)
            )
            vc.navigationItem.largeTitleDisplayMode = .automatic
            vc.tabBarItem = UITabBarItem(title: "Изображения", image: UIImage(named: "images"), selectedImage: UIImage(named: "images selected"))
            return vc
        case .asteroids:
            let vc = AsteroidsViewController(
                viewModel: Injection.shared.makeContainer().resolve(AsteroidsViewModel.self)
            )
            vc.navigationItem.largeTitleDisplayMode = .automatic
            vc.tabBarItem = UITabBarItem(title: "Астероиды", image: UIImage(named: "asteroids"), selectedImage: UIImage(named: "asteroids selected"))
            return vc
        case .videolibrary:
            let vc = NASAVideoLibraryViewController(
                factory: Injection.shared.makeContainer().resolve(NASAScreenFactoryProtocol.self)
            )
            vc.navigationItem.largeTitleDisplayMode = .automatic
            vc.tabBarItem = UITabBarItem(title: "NASA Видеотека", image: UIImage(named: "video player"), selectedImage: UIImage(named: "video player selected"))
            return vc
        case .marsweather:
            let vc = MarsWeatherViewController(
                presenter: Injection.shared.makeContainer().resolve(MarsWeatherPresenter.self)
            )
            vc.navigationItem.largeTitleDisplayMode = .automatic
            vc.tabBarItem = UITabBarItem(title: "Марс Погода", image: UIImage(systemName: "cloud"), selectedImage: UIImage(systemName: "cloud.fill"))
            return vc
        }
    }
    
    func createNASAVideoLibraryView(viewController: UIViewController & AnyObject)-> UIView {
        let view = NASAVideoLibraryListView(
            frame: .zero,
            viewModel: Injection.shared.makeContainer().resolve(NASAVideoLibraryListViewViewModel.self)
        )
        view.delegate = viewController as? any NASAVideoLibraryListViewDelegate
        return view
    }
}
