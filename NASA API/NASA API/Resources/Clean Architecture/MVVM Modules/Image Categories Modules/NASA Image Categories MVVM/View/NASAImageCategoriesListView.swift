//
//  NASAImageCategoriesListView.swift
//  NASA API
//
//  Created by Марк Киричко on 23.01.2023.
//

import UIKit

protocol NASAImageCategoriesListViewDelegate: AnyObject {
    func ShowNASAimages(didSelectCategory category: NasaImageCategory)
}

final class NASAImageCategoriesListView: UIView {

    public weak var delegate: NASAImageCategoriesListViewDelegate?
    private var viewModel: NASAImageCategoriesListViewViewModel?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(NASAImageCategoriesCollectionViewCell.self, forCellWithReuseIdentifier: NASAImageCategoriesCollectionViewCell.identifier)
        return collectionView
    }()
    
    // MARK: - Init
    init(frame: CGRect, viewModel: NASAImageCategoriesListViewViewModel?) {
        super.init(frame: frame)
        self.viewModel = viewModel
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        addConstraints()
        setUpCollectionView()
        viewModel?.delegate = self
        viewModel?.GetCategoryImages()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setUpCollectionView() {
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }
}

// MARK: - NASAImageCategoriesListViewViewModelDelegate
extension NASAImageCategoriesListView: NASAImageCategoriesListViewViewModelDelegate {
    
    func didLoadInitialCategoryImages() {
        collectionView.reloadData()
    }
    
    func didSelectCategory(_ category: NasaImageCategory) {
        delegate?.ShowNASAimages(didSelectCategory: category)
    }
}
