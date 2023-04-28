//
//  MarsPhotosListViewViewModel.swift
//  NASA API
//
//  Created by Марк Киричко on 24.01.2023.
//

import UIKit

protocol MarsPhotosListViewViewModelDelegate: NSObject {
    func didLoadInitialMarsPhotos()
    func didMarsPhotoSelected(photo: Photo)
}

class MarsPhotosListViewViewModel: NSObject {
    
    public weak var delegate: MarsPhotosListViewViewModelDelegate?
    
    private let nasaService: NASAServiceProtocol?
    
    private var marsphotos = [Photo]() {
        didSet {
            for photo in marsphotos {
                let viewModel = MarsPhotosCollectionViewCellViewModel(MarsPhoto: photo.imgSrc, RoverName: photo.rover.name, PhotoDate: photo.earthDate)
                cellViewModels.append(viewModel)
                print(cellViewModels.count)
            }
        }
    }
    private var cellViewModels = [MarsPhotosCollectionViewCellViewModel]()
    
    init(nasaService: NASAServiceProtocol?) {
        self.nasaService = nasaService
    }
    
    func GetMarsPhoto() {
        NASAService.shared.execute(type: MarsImage.self, response: .marsphotos) { [weak self] result in
            switch result {
            case .success(let data):
                self?.marsphotos = data.photos
                
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialMarsPhotos()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension MarsPhotosListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MarsPhotosCollectionViewCell.identifier, for: indexPath) as? MarsPhotosCollectionViewCell else {
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
        SoundClass.shared.PlaySound(resource: "space.wav")
        if let cell = collectionView.cellForItem(at: indexPath) as? MarsPhotosCollectionViewCell {
            cell.didCellTapped(indexPath: indexPath)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.delegate?.didMarsPhotoSelected(photo: self.marsphotos[indexPath.row])
        }
    }
}
