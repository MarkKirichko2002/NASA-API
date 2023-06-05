//
//  Injection.swift
//  NASA API
//
//  Created by Марк Киричко on 29.05.2023.
//

import Swinject

final class Injection {
    
    static let shared = Injection()
    
    private init() {}
    
    func makeContainer()-> Container {
        // Container
        let container = Container()
        // Date
        container.register(DateManager.self) { _ in
            return DateManager()
        }
        // Location
        container.register(LocationManager.self) { _ in
            return LocationManager()
        }
        // API
        container.register(NASAServiceProtocol.self) { resolver in
            return NASAService(
                dateManager:  resolver.resolve(DateManager.self),
                locationManager: resolver.resolve(LocationManager.self)
            )
        }
        // Factory
        container.register(NASAScreenFactoryProtocol.self) { _ in
            return NASAScreenFactory()
        }
        // MARK: - категории изображений
                
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
        // анимация
        container.register(AnimationClassProtocol.self) { _ in
            return AnimationClass()
        }
        // распознавание речи
        container.register(SpeechRecognitionProtocol.self) { _ in
            return SpeechRecognition()
        }
        // фабрика
        container.register(NASAScreenFactoryProtocol.self) { _ in
            return NASAScreenFactory()
        }
        return container
    }
}
