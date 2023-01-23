//
//  NASAImageCategoriesCollectionViewViewModel.swift
//  NASA API
//
//  Created by Марк Киричко on 23.01.2023.
//

import Foundation

final class NASAImageCategoriesCollectionViewCellViewModel {
    public var categoryName: String
    public var categoryImage: String
    
    init(categoryName: String, categoryImage: String) {
        self.categoryName = categoryName
        self.categoryImage = categoryImage
    }
    
}
