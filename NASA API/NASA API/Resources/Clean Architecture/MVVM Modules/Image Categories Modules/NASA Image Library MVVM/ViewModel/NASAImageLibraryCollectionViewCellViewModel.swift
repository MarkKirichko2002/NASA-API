//
//  NASAImageLibraryCollectionViewCellViewModel.swift
//  NASA API
//
//  Created by Марк Киричко on 26.01.2023.
//

import Foundation

final class NASAImageLibraryCollectionViewCellViewModel {
    
    public var NASAImage: String
    public var NASAImageTitle: String
    
    // MARK: - Init
    init(NASAImage: String, NASAImageTitle: String) {
        self.NASAImage = NASAImage
        self.NASAImageTitle = NASAImageTitle
    }
}
