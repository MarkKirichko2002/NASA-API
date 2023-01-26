//
//  EPICNASAImagesViewController.swift
//  NASA API
//
//  Created by Марк Киричко on 24.01.2023.
//

import UIKit

class EPICNASAImagesViewController: UIViewController, EPICNASAImagesListViewDelegate {
    
    private let epicNasaImagesListView = EPICNASAImagesListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        epicNasaImagesListView.delegate = self
        view.addSubviews(epicNasaImagesListView)
        SetUpView()
    }
    
    private func SetUpView() {
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
