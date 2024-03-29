//
//  EarthViewController.swift
//  Super easy dev
//
//  Created by Марк Киричко on 16.05.2023
//

import UIKit

protocol EarthViewProtocol: AnyObject {
    func PresentEarth(earth: Earth)
}

class EarthViewController: UIViewController {
    
    var presenter: EarthPresenterProtocol?
    
    let EarthImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviews(EarthImage)
        self.makeConstraints()
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            EarthImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            EarthImage.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            EarthImage.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            EarthImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
