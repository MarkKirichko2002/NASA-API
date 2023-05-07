//
//  SplashScreenController.swift
//  NASA API
//
//  Created by Марк Киричко on 23.01.2023.
//

import UIKit

final class SplashScreenController: UIViewController {
    
    private let animation: AnimationClassProtocol?
    
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
            self.GoToStartScreen()
        }
    }
    
    private func GoToStartScreen() {
        let navVC = UINavigationController()
        let coordinator = NASACoordinator()
        coordinator.navigationController = navVC
        
        guard let window = self.view.window else {return}
        window.rootViewController = navVC
        
        coordinator.start()
    }
}
