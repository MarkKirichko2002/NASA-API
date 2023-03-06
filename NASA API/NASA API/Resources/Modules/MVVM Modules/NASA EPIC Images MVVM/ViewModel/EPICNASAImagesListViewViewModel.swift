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
    
    private var epicimages = [EPIC]() {
        didSet {
            for epicimage in epicimages {
                let viewModel = NASAEPICImagesCollectionViewCellViewModel(EPICIMage: epicimage.image, EPICTitle: epicimage.caption, EPICDate: epicimage.date)
                cellViewModels.append(viewModel)
            }
        }
    }
    
    private var cellViewModels = [NASAEPICImagesCollectionViewCellViewModel]()
    
    public func GetEPICImages() {
        NASAService.shared.execute(type: [EPIC].self, response: .epic) { [weak self] result in
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

extension EPICNASAImagesListViewViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NASAEPICImagesCollectionViewCell.identifier, for: indexPath) as? NASAEPICImagesCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        SetUpImageURL(epic: epicimages[indexPath.row]) { url in
            self.cellViewModels[indexPath.row].EPICIMage = url
        }
        cell.configure(with: self.cellViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath)-> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        SoundClass.shared.PlaySound(resource: "space.wav")
        
        if let cell = collectionView.cellForItem(at: indexPath) as? NASAEPICImagesCollectionViewCell {
            cell.didCellTapped(indexPath: indexPath)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.delegate?.didEpicImageSelected(epic: self.cellViewModels[indexPath.row])
        }
    }
}
