//
//  NASASettingsViewViewModel.swift
//  NASA API
//
//  Created by Марк Киричко on 12.03.2023.
//

import UIKit

struct NASASettingsViewViewModel {
    
    let cellViewModels: [NASASettingsCellViewModel]
    
    init(cellViewModels: [NASASettingsCellViewModel]) {
        self.cellViewModels = cellViewModels
    }
    
}
