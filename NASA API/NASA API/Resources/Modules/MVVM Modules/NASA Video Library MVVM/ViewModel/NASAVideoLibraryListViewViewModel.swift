//
//  NASAVideoLibraryListViewViewModel.swift
//  NASA API
//
//  Created by Марк Киричко on 01.05.2023.
//

import UIKit

protocol NASAVideoLibraryListViewViewModelDelegate: NSObject {
    func didLoadInitialNASAVideos()
    func didSelectNASAVideo(_ video: NASAVideoLibraryCollectionViewCellViewModel)
}

class NASAVideoLibraryListViewViewModel: NSObject {
    
    public weak var delegate: NASAVideoLibraryListViewViewModelDelegate?
    
    private let nasaService: NASAServiceProtocol?
    
    private var cellViewModels = [NASAVideoLibraryCollectionViewCellViewModel]()
    
    init(nasaService: NASAServiceProtocol?) {
        self.nasaService = nasaService
    }
    
    func GetNASAVideos() {
        nasaService?.execute(type: NASAImageAndVideoLibrary.self, response: .nasavideos) { [weak self] result in
            switch result {
            case .success(let data):
                let data = data.collection.items
                DispatchQueue.main.async {
                    for item in data {
                        for video in item.links {
                            for info in item.data {
                                self?.cellViewModels.append(NASAVideoLibraryCollectionViewCellViewModel(NASAVideoImage: video.href, NASAVideoTitle: info.title, NASAVideoJSON: item.href))
                                self?.delegate?.didLoadInitialNASAVideos()
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

extension NASAVideoLibraryListViewViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath)-> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? NASAVideoLibraryCollectionViewCell {
            cell.didCellTapped(indexPath: indexPath)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.delegate?.didSelectNASAVideo(self.cellViewModels[indexPath.row])
        }
    }
}
