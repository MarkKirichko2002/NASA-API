//
//  APODPresenter + Extensions.swift
//  NASA API
//
//  Created by Марк Киричко on 22.06.2023.
//

import UIKit

// MARK: - APODPresenterProtocol
extension APODPresenter: APODPresenterProtocol {
    
    func interactorDidFetchedAPOD(apod: Apod) {
        view?.displayAPOD(apod: apod)
    }
    
    func recognizeText(image: UIImage) {
        textRecognitionManager.recognizeText(image: image) { text in
            self.interactor.recognizeText(text: text)
        }
    }
    
    func getAPODWithOtherDate(date: String) {
        interactor.fetchAPODWithOtherDate(date: date)
    }
}
