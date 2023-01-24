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
            if let vc = storyboard?.instantiateViewController(withIdentifier: "MarsPhotosViewController") as? MarsPhotosViewController {
                navigationController?.pushViewController(vc, animated: true)
            }
            
        case 2:
            let vc = storyboard?.instantiateViewController(withIdentifier: "NASAImagesTableViewController") as? NASAImagesTableViewController
            vc?.category = category
            navigationController?.pushViewController(vc!, animated: true)
            
        case 3:
            if let vc = storyboard?.instantiateViewController(withIdentifier: "EPICNASAImagesViewController") as? EPICNASAImagesViewController {
                navigationController?.pushViewController(vc, animated: true)
            }
            
        default:
            break
        }
    }
}
