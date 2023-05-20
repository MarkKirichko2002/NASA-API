//
//  NASASettingsCellViewModel.swift
//  NASA API
//
//  Created by Марк Киричко on 12.03.2023.
//

import UIKit

struct NASASettingsCellViewModel: Identifiable {
    
    let id = UUID()
    
    public let type: NASASettingsOption
    public let onTapHandler: (NASASettingsOption)-> Void
    
    //MARK: - Init
    init(type: NASASettingsOption, onTapHandler: @escaping(NASASettingsOption)-> Void) {
        self.type = type
        self.onTapHandler = onTapHandler
    }
    
    // MARK: - Public
    public var image: UIImage? {
        return type.iconImage
    }
    
    public var title: String {
        return type.displayTitle
    }
    
}
