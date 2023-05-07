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

final class NASAImageLibraryListViewViewModel: NSObject {
    
    public weak var delegate: NASAImageLibraryListViewViewModelDelegate?
    
    private let nasaService: NASAServiceProtocol?
    
    private var cellViewModels = [NASAImageLibraryCollectionViewCellViewModel]()
    
    init(nasaService: NASAServiceProtocol?) {
        self.nasaService = nasaService
    }
    
    func GetNASAImages() {
        nasaService?.execute(type: NASAImageAndVideoLibrary.self, response: .nasaimages) { [weak self] result in
            switch result {
            case .success(let data):
                let data = data.collection.items
                DispatchQueue.main.async {
                    for item in data {
                        for image in item.links {
                            for info in item.data {
                                self?.cellViewModels.append(NASAImageLibraryCollectionViewCellViewModel(NASAImage: image.href, NASAImageTitle: info.title))
                                self?.delegate?.didLoadInitialNASAImages()
                            }
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
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
        if let cell = collectionView.cellForItem(at: indexPath) as? NASAImageLibraryCollectionViewCell {
            cell.didCellTapped(indexPath: indexPath)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.delegate?.didSelectNASAImage(self.cellViewModels[indexPath.row])
        }
    }
}
