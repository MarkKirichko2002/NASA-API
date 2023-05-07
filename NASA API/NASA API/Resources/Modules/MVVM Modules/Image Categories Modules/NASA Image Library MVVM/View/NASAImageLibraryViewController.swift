//
//  NASAImageLibraryViewController.swift
//  NASA API
//
//  Created by Марк Киричко on 26.01.2023.
//

import UIKit

final class NASAImageLibraryViewController: UIViewController {
    
    private let factory = NASAScreenFactory()
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        SetUpConstraints()
    }
        
    private func SetUpConstraints() {
        let nasaImageLibraryListView = factory.createNASAImageCategoriesViews(view: .nasaimages, viewController: self)
        view.addSubview(nasaImageLibraryListView)
        NSLayoutConstraint.activate([
            nasaImageLibraryListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            nasaImageLibraryListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            nasaImageLibraryListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            nasaImageLibraryListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension NASAImageLibraryViewController: NASAImageLibraryListViewDelegate {
    
    func showNASAImageDetail(image: NASAImageLibraryCollectionViewCellViewModel) {
        let vc = NASAImageDetailViewController()
        vc.image = image.NASAImage
        vc.info = image.NASAImageTitle
        navigationController?.pushViewController(vc, animated: true)
    }
}
