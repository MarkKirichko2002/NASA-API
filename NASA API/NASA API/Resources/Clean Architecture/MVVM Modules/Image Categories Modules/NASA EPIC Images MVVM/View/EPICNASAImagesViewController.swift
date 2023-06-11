//
//  EPICNASAImagesViewController.swift
//  NASA API
//
//  Created by Марк Киричко on 24.01.2023.
//

import UIKit

final class EPICNASAImagesViewController: UIViewController, EPICNASAImagesListViewDelegate {
    
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
        view.backgroundColor = .systemBackground
        SetUpView()
    }
    
    private func SetUpView() {
        guard let epicNasaImagesListView = factory?.createNASAImageCategoriesViews(view: .epic, viewController: self) else {return}
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
