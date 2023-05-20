//
//  NASAImageCategoriesListViewController.swift
//  NASA API
//
//  Created by Марк Киричко on 23.01.2023.
//

import UIKit

final class NASAImageCategoriesListViewController: UIViewController, NASAImageCategoriesListViewDelegate {
    
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
        title = "Изображения"
        SetUpView()
    }
    
    private func SetUpView() {
        guard let nasaImageCategoriesListView = factory?.createNASAImageCategoriesViews(view: .imagecategories, viewController: self) else {return}
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
            guard let vc = factory?.createImageCategoriesScreens(screen: .apod) else {return}
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 2:
            guard let vc = factory?.createImageCategoriesScreens(screen: .marsphotos) else {return}
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 3:
            guard let vc = factory?.createImageCategoriesScreens(screen: .nasaimages) else {return}
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 4:
            guard let vc = factory?.createImageCategoriesScreens(screen: .epic) else {return}
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 5:
            guard let vc = factory?.createImageCategoriesScreens(screen: .earth) else {return}
            self.navigationController?.pushViewController(vc, animated: true)
            
        default:
            break
        }
    }
}
