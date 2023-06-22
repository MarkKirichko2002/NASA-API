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

final class NASAImageCategoriesListViewViewModel: NSObject {
    
    public weak var delegate: NASAImageCategoriesListViewViewModelDelegate?
    
    private let nasaService: NASAServiceProtocol?
    
    let cellViewModels = [NASAImageCategoriesCollectionViewCellViewModel(categoryName: "APOD", categoryImage: "camera", imagesCount: 0), NASAImageCategoriesCollectionViewCellViewModel(categoryName: "Фото Марса", categoryImage: "rover", imagesCount: 0), NASAImageCategoriesCollectionViewCellViewModel(categoryName: "NASA Изображения", categoryImage: "NASA", imagesCount: 0), NASAImageCategoriesCollectionViewCellViewModel(categoryName: "EPIC", categoryImage: "EPIC", imagesCount: 0), NASAImageCategoriesCollectionViewCellViewModel(categoryName: "Земля", categoryImage: "", imagesCount: 0)]
    let categories = [NasaImageCategory(id: 1, name: "APOD", icon: "camera", sound: "space.wav"), NasaImageCategory(id: 2, name: "Фото Марса", icon: "rover", sound: "space.wav"), NasaImageCategory(id: 3, name: "NASA Изображения", icon: "NASA", sound: "camera.mp3"), NasaImageCategory(id: 4, name: "EPIC", icon: "EPIC", sound: "space.wav"), NasaImageCategory(id: 5, name: "Земля", icon: "", sound: "space.wav")]
    
    private let epicNASAImagesListViewViewModel: EPICNASAImagesListViewViewModel?
    
    // MARK: - Init
    init(nasaService: NASAServiceProtocol?, epicNASAImagesListViewViewModel: EPICNASAImagesListViewViewModel?) {
        self.nasaService = nasaService
        self.epicNASAImagesListViewViewModel = epicNASAImagesListViewViewModel
    }
    
    func GetCategoryImages() {
        DispatchQueue.main.async {
            self.nasaService?.execute(type: Apod.self, response: .apod) { [weak self] result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self?.cellViewModels[0].categoryImage = data.hdurl ?? ""
                        self?.cellViewModels[0].imagesCount = 1
                        self?.delegate?.didLoadInitialCategoryImages()
                    }
                    Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { timer in
                        DispatchQueue.main.async {
                            self?.cellViewModels[0].categoryName = data.date ?? ""
                            self?.delegate?.didLoadInitialCategoryImages()
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            }
            self.nasaService?.execute(type: MarsImage.self, response: .marsphotos) { [weak self] result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self?.cellViewModels[1].categoryImage = data.photos[Int.random(in: 0...data.photos.count - 1)].imgSrc
                        self?.cellViewModels[1].imagesCount = data.photos.count
                        self?.delegate?.didLoadInitialCategoryImages()
                    }
                    Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
                        DispatchQueue.main.async {
                            self?.cellViewModels[1].categoryImage = data.photos[Int.random(in: 0...data.photos.count - 1)].imgSrc
                            self?.cellViewModels[1].categoryName =  data.photos[Int.random(in: 0...data.photos.count - 1)].rover.name
                            self?.delegate?.didLoadInitialCategoryImages()
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            }
            self.nasaService?.execute(type: NASAImageAndVideoLibrary.self, response: .nasaimages) { [weak self] result in
                switch result {
                case .success(let data):
                    var images = [NASAImageViewModel]()
                    let data = data.collection.items
                    DispatchQueue.main.async {
                        for item in data {
                            for image in item.links {
                                for info in item.data {
                                    images.append(NASAImageViewModel(image: image.href, title: info.title, description: info.description508 ?? ""))
                                }
                                self?.cellViewModels[2].categoryImage = images[0].image
                                self?.cellViewModels[2].imagesCount = images.count
                                self?.delegate?.didLoadInitialCategoryImages()
                            }
                        }
                    }
                    Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
                        DispatchQueue.main.async {
                            self?.cellViewModels[2].categoryImage = images[Int.random(in: 0...images.count - 1)].image
                            self?.delegate?.didLoadInitialCategoryImages()
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            }
            self.nasaService?.execute(type: [EPIC].self, response: .epic) { [weak self] result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self?.epicNASAImagesListViewViewModel?.SetUpImageURL(epic: data[0]) { image in
                            self?.cellViewModels[3].categoryImage = image
                            self?.cellViewModels[3].imagesCount = data.count
                            self?.delegate?.didLoadInitialCategoryImages()
                        }
                    }
                    Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
                        DispatchQueue.main.async {
                            self?.epicNASAImagesListViewViewModel?.SetUpImageURL(epic: data[Int.random(in: 0...data.count - 1)]) { image in
                                self?.cellViewModels[3].categoryImage = image
                                self?.cellViewModels[3].categoryName = data[Int.random(in: 0...data.count - 1)].date
                                self?.delegate?.didLoadInitialCategoryImages()
                            }
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            }
            self.nasaService?.execute(type: Earth.self, response: .earth) {  [weak self] result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self?.cellViewModels[4].categoryImage = data.url ?? ""
                        self?.cellViewModels[4].imagesCount = 1
                        self?.delegate?.didLoadInitialCategoryImages()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
