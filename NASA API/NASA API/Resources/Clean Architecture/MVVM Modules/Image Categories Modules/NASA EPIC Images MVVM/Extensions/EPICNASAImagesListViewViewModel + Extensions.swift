//
//  EPICNASAImagesListViewViewModel + Extensions.swift
//  NASA API
//
//  Created by Марк Киричко on 22.06.2023.
//

import UIKit

// MARK: - UICollectionViewDataSource
extension EPICNASAImagesListViewViewModel: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NASAEPICImagesCollectionViewCell.identifier, for: indexPath) as? NASAEPICImagesCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        SetUpImageURL(epic: epicimages[indexPath.row]) { url in
            self.cellViewModels[indexPath.row].EPICIMage = url
        }
        cell.configure(with: self.cellViewModels[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension EPICNASAImagesListViewViewModel: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        AudioPlayer.shared.PlaySound(resource: "space.wav")
        
        if let cell = collectionView.cellForItem(at: indexPath) as? NASAEPICImagesCollectionViewCell {
            cell.didCellTapped(indexPath: indexPath)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.delegate?.didEpicImageSelected(epic: self.cellViewModels[indexPath.row])
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension EPICNASAImagesListViewViewModel: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath)-> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        return CGSize(width: width, height: width * 1.5)
    }
}
