//
//  SplashScreenController.swift
//  NASA API
//
//  Created by Марк Киричко on 23.01.2023.
//

import UIKit
import Swinject

class SplashScreenController: UIViewController {
    
    private let animation: AnimationClassProtocol?
    
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
        container.register(NASATabBarController.self) { resolver in
            let vc = NASATabBarController(animation: resolver.resolve(AnimationClassProtocol.self), player: resolver.resolve(SoundClassProtocol.self), speechRecognition: resolver.resolve(SpeechRecognitionProtocol.self))
            return vc
        }
        return container
    }()
    
    private let Icon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "NASA")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var TitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviews(Icon,TitleLabel)
        SetUpConstraints()
        ShowSplashScreen()
    }
    
    init(animation: AnimationClassProtocol?) {
        self.animation = animation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func SetUpConstraints() {
        NSLayoutConstraint.activate([
            Icon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            Icon.heightAnchor.constraint(equalToConstant: 250),
            Icon.widthAnchor.constraint(equalToConstant: 250),
            
            TitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            TitleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            TitleLabel.heightAnchor.constraint(equalToConstant: 30),
            TitleLabel.topAnchor.constraint(equalTo: Icon.bottomAnchor, constant: 15)
        ])
    }
    
    private func ShowSplashScreen() {
        
        animation?.SpringAnimation(view: Icon)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.TitleLabel.text = "NASA API"
            self.animation?.SpringAnimation(view: self.TitleLabel)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            guard let vc = self.container.resolve(NASATabBarController.self) else {return}
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .currentContext
            self.present(vc, animated: false, completion: nil)
        }
    }
}
