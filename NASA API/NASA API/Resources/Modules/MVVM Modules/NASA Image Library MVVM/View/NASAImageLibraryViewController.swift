//
//  NASAImageLibraryViewController.swift
//  NASA API
//
//  Created by Марк Киричко on 26.01.2023.
//

import UIKit

class NASAImageLibraryViewController: UIViewController {
    
    let nasaImageLibraryListView = NASAImageLibraryListView()
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        view.addSubview(nasaImageLibraryListView)
        SetUpConstraints()
    }
    
    private func SetUpConstraints() {
        nasaImageLibraryListView.delegate = self
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
