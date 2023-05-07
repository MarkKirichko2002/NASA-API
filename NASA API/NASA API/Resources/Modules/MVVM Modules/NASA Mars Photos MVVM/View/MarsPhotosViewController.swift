//
//  MarsPhotosViewController.swift
//  NASA API
//
//  Created by Марк Киричко on 24.01.2023.
//

import UIKit

class MarsPhotosViewController: UIViewController {
    
    private let factory = NASAScreenFactory()
    private var viewModel: MarsPhotosListViewViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        SetUpView()
    }
    
    init(viewModel: MarsPhotosListViewViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func SetUpView() {
        let marsPhotosListView = factory.createNASAImageCategoriesViews(view: .marsphotos, viewController: self)
        view?.addSubviews(marsPhotosListView)
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
