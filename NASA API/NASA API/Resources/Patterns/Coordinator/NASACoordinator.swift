//
//  NASACoordinator.swift
//  NASA API
//
//  Created by Марк Киричко on 03.05.2023.
//

import Swinject
import UIKit

class NASACoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    private let container: Container = {
        // контейнер
        let container = Container()
        // анимация
        container.register(AnimationClassProtocol.self) { _ in
            return AnimationClass()
        }
        // аудио
        container.register(SoundClassProtocol.self) { _ in
            return SoundClass()
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
    }()
    
    var children: [Coordinator]?
    
    func eventOccured(with type: Event) {
        switch type {
        case .startButtonWasClicked:
            var vc: UIViewController & Coordinating = NASATabBarController(animation: container.resolve(AnimationClassProtocol.self), player: container.resolve(SoundClassProtocol.self), speechRecognition: container.resolve(SpeechRecognitionProtocol.self), factory: container.resolve(NASAScreenFactoryProtocol.self))
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func start() {
        var vc: UIViewController & Coordinating = NASAStartViewController()
        vc.coordinator = self
        navigationController?.setViewControllers([vc],
                                                 animated: false)
    }
}
