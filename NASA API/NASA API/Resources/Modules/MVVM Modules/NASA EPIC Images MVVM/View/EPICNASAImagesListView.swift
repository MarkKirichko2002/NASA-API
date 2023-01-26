//
//  EPICNASAImagesListView.swift
//  NASA API
//
//  Created by Марк Киричко on 24.01.2023.
//

import UIKit

protocol EPICNASAImagesListViewDelegate: NSObject {
    func showEPICImageDetail(epic: NASAEPICImagesCollectionViewCellViewModel)
}

class EPICNASAImagesListView: UIView {

    public weak var delegate: EPICNASAImagesListViewDelegate?
    
    private let viewModel = EPICNASAImagesListViewViewModel()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(NASAEPICImagesCollectionViewCell.self, forCellWithReuseIdentifier: NASAEPICImagesCollectionViewCell.identifier)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        SetUpConstraints()
        viewModel.delegate = self
        viewModel.GetEPICImages()
        setUpCollectionView()
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
    
    private func setUpCollectionView() {
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }
}

extension EPICNASAImagesListView: EPICNASAImagesListViewViewModelDelegate {
    
    func didLoadInitialEPICImages() {
        collectionView.reloadData()
    }
    
    func didEpicImageSelected(epic: NASAEPICImagesCollectionViewCellViewModel) {
        delegate?.showEPICImageDetail(epic: epic)
    }
}
