//
//  NASAStartViewController.swift
//  NASA API
//
//  Created by Марк Киричко on 03.05.2023.
//

import UIKit

final class NASAStartViewController: UIViewController, Coordinating {
    
    var coordinator: Coordinator?
    
    private let NASAIcon: RoundedImageView = {
        let icon = RoundedImageView()
        icon.sound = "space.wav"
        icon.image = UIImage(named: "NASA")
        icon.contentMode = .scaleAspectFill
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private let TitleLabel: UILabel = {
        let label = UILabel()
        label.text = "NASA API"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let StartButton: UIButton = {
        let button = UIButton()
        button.setTitle("Начать", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviews(NASAIcon,TitleLabel,StartButton)
        StartButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        makeConstraints()
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            NASAIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            NASAIcon.widthAnchor.constraint(equalToConstant: 200),
            NASAIcon.heightAnchor.constraint(equalToConstant: 200),
            
            TitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            TitleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            TitleLabel.heightAnchor.constraint(equalToConstant: 30),
            TitleLabel.topAnchor.constraint(equalTo: NASAIcon.bottomAnchor, constant: 50),
            
            StartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            StartButton.heightAnchor.constraint(equalToConstant: 30),
            StartButton.topAnchor.constraint(equalTo: TitleLabel.bottomAnchor, constant: 50)
        ])
    }
    
    @objc private func didTapButton() {
        coordinator?.eventOccured(with: .startButtonWasClicked)
    }
}
