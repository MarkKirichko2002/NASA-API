//
//  MarsPhotosViewController.swift
//  NASA API
//
//  Created by Марк Киричко on 24.01.2023.
//

import UIKit

final class MarsPhotosViewController: UIViewController {
    
    private let factory: NASAScreenFactoryProtocol?
    
    // MARK: - Init
    init(factory: NASAScreenFactoryProtocol?) {
        self.factory = factory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        SetUpView()
    }
    
    private func SetUpView() {
        guard let marsPhotosListView = factory?.createNASAImageCategoriesViews(view: .marsphotos, viewController: self) else {return}
        view?.addSubviews(marsPhotosListView)
        NSLayoutConstraint.activate([
            marsPhotosListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            marsPhotosListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            marsPhotosListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            marsPhotosListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - MarsPhotosListViewDelegate
extension MarsPhotosViewController: MarsPhotosListViewDelegate {
    func showMarsPhotosDetail(photo: Photo) {
        let vc = NASAImageDetailViewController()
        vc.image = photo.imgSrc
        vc.info = "Camera Name: \(photo.camera.fullName) \n \n Landing Date: \(photo.rover.landingDate) \n \n EarthDate: \(photo.earthDate)"
        vc.sound = "space.wav"
        navigationController?.pushViewController(vc, animated: true)
    }
}
