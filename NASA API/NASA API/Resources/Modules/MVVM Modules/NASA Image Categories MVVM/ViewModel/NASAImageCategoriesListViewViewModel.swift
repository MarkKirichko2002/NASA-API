//
//  NASAImageCategoriesListViewViewModel.swift
//  NASA API
//
//  Created by Марк Киричко on 23.01.2023.
//

import UIKit

protocol NASAImageCategoriesListViewViewModelDelegate: AnyObject {
    func didLoadInitialCategoryImages()
    func didSelectCategory(_ category: NasaImageCategory)
}

class NASAImageCategoriesListViewViewModel: NSObject {
    
    public weak var delegate: NASAImageCategoriesListViewViewModelDelegate?
    
    private let apiManager = NASAService()
    
    private let cellViewModels = [NASAImageCategoriesCollectionViewCellViewModel(categoryName: "APOD", categoryImage: "camera", imagesCount: 0), NASAImageCategoriesCollectionViewCellViewModel(categoryName: "Mars Rover Photos", categoryImage: "rover", imagesCount: 0), NASAImageCategoriesCollectionViewCellViewModel(categoryName: "NASA Image Library", categoryImage: "NASA", imagesCount: 0), NASAImageCategoriesCollectionViewCellViewModel(categoryName: "EPIC", categoryImage: "EPIC", imagesCount: 0)]
    private let categories = [NasaImageCategory(id: 1, name: "APOD", icon: "camera", sound: "space.wav"), NasaImageCategory(id: 2, name: "NASA Mars Rover Images", icon: "rover", sound: "space.wav"), NasaImageCategory(id: 3, name: "NASA Image Library", icon: "NASA", sound: "camera.mp3"), NasaImageCategory(id: 4, name: "EPIC", icon: "EPIC", sound: "space.wav")]
    private let epicNASAImagesListViewViewModel = EPICNASAImagesListViewViewModel()
    
    func GetCategoryImages() {
        DispatchQueue.main.async {
            self.apiManager.fetchAPOD { apod in
                DispatchQueue.main.async {
                    self.cellViewModels[0].categoryImage = apod.hdurl
                    self.cellViewModels[0].imagesCount = 1
                    self.delegate?.didLoadInitialCategoryImages()
                }
            }
            self.apiManager.fetchMarsPhotos { photo in
                DispatchQueue.main.async {
                    self.cellViewModels[1].categoryImage = photo[Int.random(in: 0...photo.count)].imgSrc
                    self.cellViewModels[1].imagesCount = photo.count
                    self.delegate?.didLoadInitialCategoryImages()
                }
            }
            self.apiManager.fetchNASAImages { images in
                DispatchQueue.main.async {
                    self.cellViewModels[2].categoryImage = images[0].image
                    self.cellViewModels[2].imagesCount = images.count
                    self.delegate?.didLoadInitialCategoryImages()
                }
            }
            self.apiManager.fetchEPICImages { epicimages in
                DispatchQueue.main.async {
                    self.epicNASAImagesListViewViewModel.SetUpImageURL(epic: epicimages[0]) { image in
                        self.cellViewModels[3].categoryImage = image
                        self.cellViewModels[3].imagesCount = epicimages.count
                        self.delegate?.didLoadInitialCategoryImages()
                    }
                }
            }
        }
    }
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
        SoundClass.shared.PlaySound(resource: category.sound)
        if let cell = collectionView.cellForItem(at: indexPath) as? NASAImageCategoriesCollectionViewCell {
            cell.didCellTapped(indexPath: indexPath)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.delegate?.didSelectCategory(category)
        }
    }
}
