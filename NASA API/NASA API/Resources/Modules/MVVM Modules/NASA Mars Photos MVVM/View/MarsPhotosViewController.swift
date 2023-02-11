//
//  MarsPhotosViewController.swift
//  NASA API
//
//  Created by Марк Киричко on 24.01.2023.
//

import UIKit

class MarsPhotosViewController: UIViewController {
    
    private let marsPhotosListView = MarsPhotosListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view?.addSubviews(marsPhotosListView)
        marsPhotosListView.delegate = self
        SetUpView()
    }
    
    private func SetUpView() {
        NSLayoutConstraint.activate([
            marsPhotosListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            marsPhotosListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            marsPhotosListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            marsPhotosListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension MarsPhotosViewController: MarsPhotosListViewDelegate {
    func showMarsPhotosDetail(photo: Photo) {
        let vc = NASAImageDetailViewController()
        vc.image = photo.imgSrc
        vc.info = "Camera Name: \(photo.camera.fullName) \n \n Landing Date: \(photo.rover.landingDate) \n \n EarthDate: \(photo.earthDate)"
        vc.sound = "space.wav"
        navigationController?.pushViewController(vc, animated: true)
    }
}
