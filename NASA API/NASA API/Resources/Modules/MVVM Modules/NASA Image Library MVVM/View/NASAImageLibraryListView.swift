//
//  NASAImageLibraryListView.swift
//  NASA API
//
//  Created by Марк Киричко on 26.01.2023.
//

import UIKit

protocol NASAImageLibraryListViewDelegate: NSObject {
    func showNASAImageDetail(image: NASAImageLibraryCollectionViewCellViewModel)
}

class NASAImageLibraryListView: UIView {
    
    public weak var delegate: NASAImageLibraryListViewDelegate?
    private var viewModel: NASAImageLibraryListViewViewModel?
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    init(frame: CGRect, viewModel: NASAImageLibraryListViewViewModel?) {
        super.init(frame: frame)
        self.viewModel = viewModel
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(collectionView)
        SetUpConstarints()
        SetUpCollection()
        collectionView.register(NASAImageLibraryCollectionViewCell.self, forCellWithReuseIdentifier: NASAImageLibraryCollectionViewCell.identifier)
        viewModel?.delegate = self
        viewModel?.GetNASAImages()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func SetUpConstarints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func SetUpCollection() {
        collectionView.delegate = viewModel
        collectionView.dataSource = viewModel
    }
    
}

extension NASAImageLibraryListView: NASAImageLibraryListViewViewModelDelegate {
    
    func didLoadInitialNASAImages() {
        collectionView.reloadData()
    }
    
    func didSelectNASAImage(_ image: NASAImageLibraryCollectionViewCellViewModel) {
        delegate?.showNASAImageDetail(image: image)
    }
    
}
