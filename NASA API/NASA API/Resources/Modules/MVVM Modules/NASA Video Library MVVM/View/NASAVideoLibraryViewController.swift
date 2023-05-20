//
//  NASAVideoLibraryViewController.swift
//  NASA API
//
//  Created by Марк Киричко on 01.05.2023.
//

import UIKit

final class NASAVideoLibraryViewController: UIViewController {
    
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
        title = "NASA Видеотека"
        view.backgroundColor = .systemBackground
        SetUpConstraints()
    }
    
    private func SetUpConstraints() {
        guard let nasaVideoLibraryListView = factory?.createNASAVideoLibraryView(viewController: self) else {return}
        view.addSubview(nasaVideoLibraryListView)
        NSLayoutConstraint.activate([
            nasaVideoLibraryListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            nasaVideoLibraryListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            nasaVideoLibraryListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            nasaVideoLibraryListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

// MARK: - NASAVideoLibraryListViewDelegate
extension NASAVideoLibraryViewController: NASAVideoLibraryListViewDelegate {
    
    func showNASAVideoDetail(video: NASAVideoLibraryCollectionViewCellViewModel) {
        let vc = VideoPlayerViewController()
        vc.json = video.NASAVideoJSON
        navigationController?.pushViewController(vc, animated: true)
    }
}
