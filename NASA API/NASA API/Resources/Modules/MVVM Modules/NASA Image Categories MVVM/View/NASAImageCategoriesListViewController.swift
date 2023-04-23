//
//  NASAImageCategoriesListViewController.swift
//  NASA API
//
//  Created by Марк Киричко on 23.01.2023.
//

import UIKit
import Swinject

class NASAImageCategoriesListViewController: UIViewController, NASAImageCategoriesListViewDelegate {
    
    private let container: Container = {
        let container = Container()
        // API
        container.register(NASAServiceProtocol.self) { _ in
            return NASAService()
        }
        // ViewModel
        container.register(NASAImageCategoriesListViewViewModel.self) { resolver in
            let viewModel = NASAImageCategoriesListViewViewModel(nasaService: resolver.resolve(NASAServiceProtocol.self))
            return viewModel
        }
        return container
    }()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Изображения"
        SetUpView()
    }
    
    private func SetUpView() {
        let nasaImageCategoriesListView = NASAImageCategoriesListView(frame: .zero, viewModel: container.resolve(NASAImageCategoriesListViewViewModel.self))
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
            
        case 5:
            let vc = EarthViewController()
            vc.title = category.name
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
            
        default:
            break
        }
    }
}
