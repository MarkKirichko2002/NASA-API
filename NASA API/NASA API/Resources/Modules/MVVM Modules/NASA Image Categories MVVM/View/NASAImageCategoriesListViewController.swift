//
//  NASAImageCategoriesListViewController.swift
//  NASA API
//
//  Created by Марк Киричко on 23.01.2023.
//

import UIKit

class NASAImageCategoriesListViewController: UIViewController, NASAImageCategoriesListViewDelegate {
    
    private let factory = NASAScreenFactory()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Изображения"
        SetUpView()
    }
    
    private func SetUpView() {
        let nasaImageCategoriesListView = factory.createNASAImageCategoriesViews(view: .imagecategories, viewController: self)
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
            let vc = factory.createImageCategoriesScreens(screen: .apod)
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 2:
            let vc = factory.createImageCategoriesScreens(screen: .marsphotos)
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 3:
            let vc = factory.createImageCategoriesScreens(screen: .nasaimages)
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 4:
            let vc = factory.createImageCategoriesScreens(screen: .epic)
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 5:
            let vc = factory.createImageCategoriesScreens(screen: .earth)
            self.navigationController?.pushViewController(vc, animated: true)
            
        default:
            break
        }
    }
}
