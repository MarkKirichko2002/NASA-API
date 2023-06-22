//
//  NASAVideoLibraryListViewViewModel + Extensions.swift
//  NASA API
//
//  Created by Марк Киричко on 22.06.2023.
//

import UIKit

// MARK: - UICollectionViewDataSource
extension NASAVideoLibraryListViewViewModel: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NASAVideoLibraryCollectionViewCell.identifier, for: indexPath) as? NASAVideoLibraryCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(with: cellViewModels[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension NASAVideoLibraryListViewViewModel: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? NASAVideoLibraryCollectionViewCell {
            cell.didCellTapped(indexPath: indexPath)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.delegate?.didSelectNASAVideo(self.cellViewModels[indexPath.row])
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension NASAVideoLibraryListViewViewModel: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath)-> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        return CGSize(width: width, height: width * 1.5)
    }
}
