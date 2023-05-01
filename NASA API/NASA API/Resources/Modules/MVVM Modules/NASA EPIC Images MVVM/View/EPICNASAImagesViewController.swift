//
//  EPICNASAImagesViewController.swift
//  NASA API
//
//  Created by Марк Киричко on 24.01.2023.
//

import UIKit
import Swinject

class EPICNASAImagesViewController: UIViewController, EPICNASAImagesListViewDelegate {
    
    private let container: Container = {
        let container = Container()
        // ViewModel
        container.register(EPICNASAImagesListViewViewModel.self) { resolver in
            let viewModel = EPICNASAImagesListViewViewModel(nasaService: resolver.resolve(NASAServiceProtocol.self))
            return viewModel
        }
        return container
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        SetUpView()
    }
    
    private func SetUpView() {
        let epicNasaImagesListView = EPICNASAImagesListView(frame: .zero, viewModel: container.resolve(EPICNASAImagesListViewViewModel.self))
        epicNasaImagesListView.delegate = self
        view.addSubviews(epicNasaImagesListView)
        NSLayoutConstraint.activate([
            epicNasaImagesListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            epicNasaImagesListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            epicNasaImagesListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            epicNasaImagesListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func showEPICImageDetail(epic: NASAEPICImagesCollectionViewCellViewModel) {
        let vc = NASAImageDetailViewController()
        vc.image = epic.EPICIMage
        vc.info = "Title: \(epic.EPICTitle) \n \n Date: \(epic.EPICDate)"
        vc.sound = "space.wav"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
