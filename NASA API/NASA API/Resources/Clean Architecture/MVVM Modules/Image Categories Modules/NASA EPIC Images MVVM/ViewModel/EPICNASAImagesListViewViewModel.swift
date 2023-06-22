//
//  EPICNASAImagesListViewViewModel.swift
//  NASA API
//
//  Created by Марк Киричко on 24.01.2023.
//

import UIKit

protocol EPICNASAImagesListViewViewModelDelegate:NSObject {
    func didLoadInitialEPICImages()
    func didEpicImageSelected(epic: NASAEPICImagesCollectionViewCellViewModel)
}

final class EPICNASAImagesListViewViewModel: NSObject {
    
    public weak var delegate: EPICNASAImagesListViewViewModelDelegate?
    
    private let nasaService: NASAServiceProtocol?
    
    var epicimages = [EPIC]() {
        didSet {
            for epicimage in epicimages {
                let viewModel = NASAEPICImagesCollectionViewCellViewModel(EPICIMage: epicimage.image, EPICTitle: epicimage.caption, EPICDate: epicimage.date)
                cellViewModels.append(viewModel)
            }
        }
    }
    
    var cellViewModels = [NASAEPICImagesCollectionViewCellViewModel]()
    
    // MARK: - Init
    init(nasaService: NASAServiceProtocol?) {
        self.nasaService = nasaService
    }
    
    public func GetEPICImages() {
        nasaService?.execute(type: [EPIC].self, response: .epic) { [weak self] result in
            switch result {
                
            case .success(let data):
                self?.epicimages = data
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialEPICImages()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func SetUpImageURL(epic: EPIC, completion: @escaping(String)->()) {
        var image = ""
        image = epic.image
        image += ".png"
        let dateString = epic.date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss 'UTC'"
        let date = formatter.date(from: dateString)
        formatter.dateFormat = "yyyy"
        let year = formatter.string(from: date!)
        formatter.dateFormat = "MM"
        let month = formatter.string(from: date!)
        formatter.dateFormat = "dd"
        let day = formatter.string(from: date!)
        let totaldate = year + "/" + month + "/" + day
        completion("https://epic.gsfc.nasa.gov/archive/natural/\(totaldate)/png/\(image)")
    }
}
