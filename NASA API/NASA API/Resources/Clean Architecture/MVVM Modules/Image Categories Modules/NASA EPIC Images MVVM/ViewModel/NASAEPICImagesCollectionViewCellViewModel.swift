//
//  NASAEPICImagesCollectionViewCellViewModel.swift
//  NASA API
//
//  Created by Марк Киричко on 24.01.2023.
//

import Foundation

final class NASAEPICImagesCollectionViewCellViewModel {
    
    public var EPICIMage: String
    public var EPICTitle: String
    public var EPICDate: String
    
    // MARK: - Init
    init(EPICIMage: String, EPICTitle: String, EPICDate: String) {
        self.EPICIMage = EPICIMage
        self.EPICTitle = EPICTitle
        self.EPICDate = EPICDate
    }
}
