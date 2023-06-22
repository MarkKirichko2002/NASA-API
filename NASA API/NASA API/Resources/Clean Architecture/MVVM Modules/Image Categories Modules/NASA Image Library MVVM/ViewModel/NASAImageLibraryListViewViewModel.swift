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
    
    var cellViewModels = [NASAImageLibraryCollectionViewCellViewModel]()
    
    // MARK: - Init
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
