//
//  EarthViewController.swift
//  NASA API
//
//  Created by Марк Киричко on 15.04.2023.
//

import UIKit
import SDWebImage

final class EarthViewController: UIViewController {

    private var presenter: EarthPresenter?
    
    private let EarthImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviews(EarthImage)
        self.makeConstraints()
        presenter?.SetViewDelegate(delegate: self)
        presenter?.GetEarthImage()
    }
    
    init(presenter: EarthPresenter?) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            EarthImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            EarthImage.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            EarthImage.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            EarthImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension EarthViewController: EarthPresentDelegate {
    func PresentEarth(earth: Earth) {
        EarthImage.sd_setImage(with: URL(string: earth.url ?? ""))
    }
}
