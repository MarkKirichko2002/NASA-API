//
//  NASASettingsOption.swift
//  NASA API
//
//  Created by Марк Киричко on 12.03.2023.
//

import UIKit

enum NASASettingsOption: CaseIterable {
    case livePreview
    
    var iconImage: UIImage? {
        switch self {
        case .livePreview:
            return UIImage(named: "NASA")
        }
    }
    
    var displayTitle: String {
        switch self {
        case .livePreview:
            return "Live Preview"
        }
    }
    
    var displayDescription: String {
        switch self {
        case .livePreview:
            return "динамический предосмотр контекта NASA"
        }
    }
}
