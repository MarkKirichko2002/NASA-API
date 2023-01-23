//
//  NASAImageCategoriesListViewViewModel.swift
//  NASA API
//
//  Created by Марк Киричко on 23.01.2023.
//

import UIKit

protocol NASAImageCategoriesListViewViewModelDelegate: AnyObject {
    func didSelectCategory(_ category: NasaImageCategory)
}

class NASAImageCategoriesListViewViewModel: NSObject {
    
    public weak var delegate: NASAImageCategoriesListViewViewModelDelegate?
    
    private let cellViewModels = [NASAImageCategoriesCollectionViewCellViewModel(categoryName: "Mars Rover Photos", categoryImage: "rover"), NASAImageCategoriesCollectionViewCellViewModel(categoryName: "NASA Image Library", categoryImage: "NASA"), NASAImageCategoriesCollectionViewCellViewModel(categoryName: "EPIC", categoryImage: "EPIC")]
    private let categories = [NasaImageCategory(id: 1, name: "NASA Mars Rover Images", icon: "rover"), NasaImageCategory(id: 2, name: "NASA Image Library", icon: "NASA"), NasaImageCategory(id: 3, name: "EPIC", icon: "EPIC")]
}

extension NASAImageCategoriesListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)-> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NASAImageCategoriesCollectionViewCell.identifier, for: indexPath) as? NASAImageCategoriesCollectionViewCell else {
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
        collectionView.deselectItem(at: indexPath, animated: true)
        let category = categories[indexPath.row]
        delegate?.didSelectCategory(category)
    }
    
}
