//
//  NASAVideoLibraryCollectionViewCellViewModel.swift
//  NASA API
//
//  Created by Марк Киричко on 01.05.2023.
//

import Foundation

final class NASAVideoLibraryCollectionViewCellViewModel {
    
    public var NASAVideoImage: String
    public var NASAVideoTitle: String
    public var NASAVideoJSON: String
    
    // MARK: - Init
    init(NASAVideoImage: String, NASAVideoTitle: String, NASAVideoJSON: String) {
        self.NASAVideoImage = NASAVideoImage
        self.NASAVideoTitle = NASAVideoTitle
        self.NASAVideoJSON = NASAVideoJSON
    }
}

