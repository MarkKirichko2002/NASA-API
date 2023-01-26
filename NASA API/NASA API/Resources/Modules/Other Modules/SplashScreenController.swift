//
//  SplashScreenController.swift
//  NASA API
//
//  Created by Марк Киричко on 23.01.2023.
//

import UIKit

class SplashScreenController: UIViewController {
    
    private let animation = AnimationClass()
    
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
        view.backgroundColor = .white
        view.addSubviews(Icon,TitleLabel)
        SetUpConstraints()
        SplashScreen()
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
    
    private func SplashScreen() {
        
        animation.springImage(image: Icon)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.TitleLabel.text = "NASA API"
            self.animation.springLabel(label: self.TitleLabel)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            let vc = NASATabBarController()
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .currentContext
            self.present(vc, animated: false, completion: nil)
        }
    }
}
