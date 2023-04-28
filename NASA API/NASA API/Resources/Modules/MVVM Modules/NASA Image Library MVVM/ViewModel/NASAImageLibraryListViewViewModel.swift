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
    
    public weak var delegate: NASAImageLibraryListViewViewModelDelegate?
    
    private let nasaService: NASAServiceProtocol?
    
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
    
    init(nasaService: NASAServiceProtocol?) {
        self.nasaService = nasaService
    }
    
    func GetNASAImages() {
        nasaService?.execute(type: NASAImageAndVideoLibrary.self, response: .nasaimages) { [weak self] result in
            switch result {
            case .success(let data):
                let data = data.collection.items
                DispatchQueue.main.async {
                    for i in data {
                        for i in i.links {
                            self?.images.append(NASAImageViewModel(image: i.href))
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
        nasaService?.execute(type: NASAImageAndVideoLibrary.self, response: .nasaimagesinfo) { [weak self] result in
            switch result {
            case .success(let data):
                let data = data.collection.items
                DispatchQueue.main.async {
                    for i in data {
                        for i in i.data {
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                            let date = dateFormatter.date(from:i.dateCreated)!
                            let calendar = Calendar.current
                            let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
                            let finalDate = calendar.date(from:components)
                            self?.imagesinfo.append(NASAImageInfoViewModel(title: i.title, date: "\(finalDate ?? Date())", description: i.dataDescription))
                        }
                    }
                    self?.delegate?.didLoadInitialNASAImages()
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
