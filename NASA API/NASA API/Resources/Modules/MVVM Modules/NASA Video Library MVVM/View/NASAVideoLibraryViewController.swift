//
//  NASAVideoLibraryViewController.swift
//  NASA API
//
//  Created by Марк Киричко on 01.05.2023.
//

import UIKit
import Swinject

class NASAVideoLibraryViewController: UIViewController {
    
    private let container: Container = {
        let container = Container()
        // API
        container.register(NASAServiceProtocol.self) { _ in
            return NASAService()
        }
        // ViewModel
        container.register(NASAVideoLibraryListViewViewModel.self) { resolver in
            let viewModel = NASAVideoLibraryListViewViewModel(nasaService: resolver.resolve(NASAServiceProtocol.self))
            return viewModel
        }
        return container
    }()
    
    override func viewDidLoad() {
        title = "NASA Видеотека"
        view.backgroundColor = .systemBackground
        SetUpConstraints()
    }
    
    private func SetUpConstraints() {
        let nasaVideoLibraryListView = NASAVideoLibraryListView(frame: .zero, viewModel: container.resolve(NASAVideoLibraryListViewViewModel.self))
        nasaVideoLibraryListView.delegate = self
        view.addSubview(nasaVideoLibraryListView)
        NSLayoutConstraint.activate([
            nasaVideoLibraryListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            nasaVideoLibraryListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            nasaVideoLibraryListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            nasaVideoLibraryListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension NASAVideoLibraryViewController: NASAVideoLibraryListViewDelegate {
    
    func showNASAVideoDetail(video: NASAVideoLibraryCollectionViewCellViewModel) {
        let vc = VideoPlayerViewController()
        vc.json = video.NASAVideoJSON
        navigationController?.pushViewController(vc, animated: true)
    }
}
