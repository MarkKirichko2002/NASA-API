//
//  NASASettingsOption.swift
//  NASA API
//
//  Created by Марк Киричко on 12.03.2023.
//

import UIKit

enum NASASettingsOption: CaseIterable {
    case apiReference
    
    var targetUrl: URL? {
        switch self {
        case .apiReference:
            return URL(string: "https://api.nasa.gov/")
        }
    }
    
    var displayTitle: String {
        switch self {
        case .apiReference:
            return "ссылка на API"
        }
    }
    
    var iconImage: UIImage? {
        switch self {
        case .apiReference:
            return UIImage(named: "NASA")
        }
    }
    
}
