//
//  EPICNASAImagesViewController.swift
//  NASA API
//
//  Created by Марк Киричко on 24.01.2023.
//

import UIKit

class EPICNASAImagesViewController: UIViewController, EPICNASAImagesListViewDelegate {
    
    private let factory = NASAScreenFactory()
    private var viewModel: EPICNASAImagesListViewViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        SetUpView()
    }
    
    init(viewModel: EPICNASAImagesListViewViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func SetUpView() {
        let epicNasaImagesListView = factory.createNASAImageCategoriesViews(view: .epic, viewController: self)
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
