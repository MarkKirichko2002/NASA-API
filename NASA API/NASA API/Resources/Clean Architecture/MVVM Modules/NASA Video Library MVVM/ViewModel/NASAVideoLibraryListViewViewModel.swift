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

final class NASAVideoLibraryListViewViewModel: NSObject {
    
    public weak var delegate: NASAVideoLibraryListViewViewModelDelegate?
    
    private let nasaService: NASAServiceProtocol?
    
    var cellViewModels = [NASAVideoLibraryCollectionViewCellViewModel]()
    
    // MARK: - Init
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
