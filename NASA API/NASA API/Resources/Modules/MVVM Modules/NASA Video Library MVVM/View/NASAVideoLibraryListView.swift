//
//  NASAVideoLibraryListView.swift
//  NASA API
//
//  Created by Марк Киричко on 01.05.2023.
//

import UIKit

protocol NASAVideoLibraryListViewDelegate: NSObject {
    func showNASAVideoDetail(video: NASAVideoLibraryCollectionViewCellViewModel)
}

class NASAVideoLibraryListView: UIView {
    
    public weak var delegate: NASAVideoLibraryListViewDelegate?
    private var viewModel: NASAVideoLibraryListViewViewModel?
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    init(frame: CGRect, viewModel: NASAVideoLibraryListViewViewModel?) {
        super.init(frame: frame)
        self.viewModel = viewModel
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(collectionView)
        SetUpConstarints()
        SetUpCollection()
        collectionView.register(NASAVideoLibraryCollectionViewCell.self, forCellWithReuseIdentifier: NASAVideoLibraryCollectionViewCell.identifier)
        viewModel?.delegate = self
        viewModel?.GetNASAVideos()
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

extension NASAVideoLibraryListView: NASAVideoLibraryListViewViewModelDelegate {
    
    func didLoadInitialNASAVideos() {
        collectionView.reloadData()
    }
    
    func didSelectNASAVideo(_ video: NASAVideoLibraryCollectionViewCellViewModel) {
        delegate?.showNASAVideoDetail(video: video)
    }
}
