//
//  NASAImageCategoriesListViewController.swift
//  NASA API
//
//  Created by Марк Киричко on 23.01.2023.
//

import UIKit

class NASAImageCategoriesListViewController: UIViewController, NASAImageCategoriesListViewDelegate {
    
    private let nasaImageCategoriesListView = NASAImageCategoriesListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "NASA Images"
        SetUpView()
    }
    
    private func SetUpView() {
        nasaImageCategoriesListView.delegate = self
        view.addSubview(nasaImageCategoriesListView)
        NSLayoutConstraint.activate([
            nasaImageCategoriesListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            nasaImageCategoriesListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            nasaImageCategoriesListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            nasaImageCategoriesListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func ShowNASAimages(didSelectCategory category: NasaImageCategory) {
        
        switch category.id {
            
        case 1:
            let vc = APODViewController()
            vc.title = category.name
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
            
        case 2:
            let vc = MarsPhotosViewController()
            vc.title = "Mars Photos"
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
            
        case 3:
            let vc = NASAImageLibraryViewController()
            vc.title = category.name
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
            
        case 4:
            let vc = EPICNASAImagesViewController()
            vc.title = category.name
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
            
        default:
            break
        }
    }
}
