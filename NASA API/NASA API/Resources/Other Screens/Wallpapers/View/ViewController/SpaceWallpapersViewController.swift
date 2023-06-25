//
//  SpaceWallpapersViewController.swift
//  NASA API
//
//  Created by Марк Киричко on 25.06.2023.
//

import UIKit

class SpaceWallpapersViewController: UIViewController {
    
    var wallpapers = [
        "https://i.pinimg.com/564x/87/0d/cd/870dcd8253b433097f96e23fc396f66e.jpg",
        "https://i.pinimg.com/564x/d6/e3/2b/d6e32bf37b8d9040f8b012406ddeed38.jpg",
        "https://i.pinimg.com/564x/de/bc/e2/debce2c84d3de82b13d5788394ba91a6.jpg",
        "https://i.pinimg.com/564x/9f/ab/a2/9faba280e0caf0454563955b6207967c.jpg"
    ]
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(WallpaperCollectionViewCell.self, forCellWithReuseIdentifier: WallpaperCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Космос Обои"
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

