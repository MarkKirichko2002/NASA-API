//
//  NASAImageLibraryListViewViewModel.swift
//  NASA API
//
//  Created by Марк Киричко on 26.01.2023.
//

import UIKit

protocol NASAImageLibraryListViewViewModelDelegate: NSObject {
    func didLoadInitialNASAImages()
    func didSelectNASAImage(_ image: NASAImageLibraryCollectionViewCellViewModel)
}

class NASAImageLibraryListViewViewModel: NSObject {
    
    weak var delegate: NASAImageLibraryListViewViewModelDelegate?
    
    private var cellViewModels = [NASAImageLibraryCollectionViewCellViewModel]()
    private var images = [NASAImageViewModel]() {
        didSet {
            for image in images {
                let viewModel = NASAImageLibraryCollectionViewCellViewModel(NASAImage: image.image, NASAImageTitle: image.image)
                cellViewModels.append(viewModel)
            }
        }
    }
    
    private var imagesinfo = [NASAImageInfoViewModel]()
    
    func GetNASAImages() {
        APIManager.shared.fetchNASAImages { images in
            self.images = images
        }
        APIManager.shared.fetchNASAImagesInfo { info in
            self.imagesinfo = info
            self.delegate?.didLoadInitialNASAImages()
        }
    }
}

extension NASAImageLibraryListViewViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NASAImageLibraryCollectionViewCell.identifier, for: indexPath) as? NASAImageLibraryCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(with: cellViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath)-> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectNASAImage(cellViewModels[indexPath.row])
    }
    
}