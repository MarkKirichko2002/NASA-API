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

final class MarsPhotosListViewViewModel: NSObject {
    
    public weak var delegate: MarsPhotosListViewViewModelDelegate?
    
    private let nasaService: NASAServiceProtocol?
    
    var marsphotos = [Photo]() {
        didSet {
            for photo in marsphotos {
                let viewModel = MarsPhotosCollectionViewCellViewModel(MarsPhoto: photo.imgSrc, RoverName: photo.rover.name, PhotoDate: photo.earthDate)
                cellViewModels.append(viewModel)
                print(cellViewModels.count)
            }
        }
    }
    var cellViewModels = [MarsPhotosCollectionViewCellViewModel]()
    
    // MARK: - Init
    init(nasaService: NASAServiceProtocol?) {
        self.nasaService = nasaService
    }
    
    func GetMarsPhoto() {
        nasaService?.execute(type: MarsImage.self, response: .marsphotos) { [weak self] result in
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
