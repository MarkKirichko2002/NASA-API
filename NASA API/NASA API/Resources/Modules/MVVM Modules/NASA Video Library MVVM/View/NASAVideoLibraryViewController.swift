//
//  NASAVideoLibraryViewController.swift
//  NASA API
//
//  Created by Марк Киричко on 01.05.2023.
//

import UIKit

final class NASAVideoLibraryViewController: UIViewController {
    
    private let factory = NASAScreenFactory()
    
    override func viewDidLoad() {
        title = "NASA Видеотека"
        view.backgroundColor = .systemBackground
        SetUpConstraints()
    }
    
    private func SetUpConstraints() {
        let nasaVideoLibraryListView = factory.createNASAVideoLibraryView(viewController: self)
        //nasaVideoLibraryListView.delegate = self
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
