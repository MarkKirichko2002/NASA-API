//
//  MarsPhotosCollectionViewCellViewModel.swift
//  NASA API
//
//  Created by Марк Киричко on 24.01.2023.
//

import Foundation

final class MarsPhotosCollectionViewCellViewModel {
    
    public var MarsPhoto: String
    public var RoverName: String
    public var PhotoDate: String
    
    init(MarsPhoto: String, RoverName: String, PhotoDate: String) {
        self.MarsPhoto = MarsPhoto
        self.RoverName = RoverName
        self.PhotoDate = PhotoDate
    }
}
