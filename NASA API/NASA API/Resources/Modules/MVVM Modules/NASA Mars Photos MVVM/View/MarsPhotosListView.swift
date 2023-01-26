//
//  MarsPhotosListView.swift
//  NASA API
//
//  Created by Марк Киричко on 24.01.2023.
//

import UIKit

protocol MarsPhotosListViewDelegate: NSObject {
    func showMarsPhotosDetail(photo: Photo)
}

class MarsPhotosListView: UIView {
    
    private let viewModel = MarsPhotosListViewViewModel()
    
    weak var delegate: MarsPhotosListViewDelegate?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MarsPhotosCollectionViewCell.self, forCellWithReuseIdentifier: MarsPhotosCollectionViewCell.identifier)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        viewModel.delegate = self
        SetUpConstraints()
        SetUpCollectionView()
        viewModel.GetMarsPhoto()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func SetUpConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func SetUpCollectionView() {
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }
}

extension MarsPhotosListView: MarsPhotosListViewViewModelDelegate {
    
    func didLoadInitialMarsPhotos() {
        collectionView.reloadData()
    }
    
    func didMarsPhotoSelected(photo: Photo) {
        delegate?.showMarsPhotosDetail(photo: photo)
    }
}
