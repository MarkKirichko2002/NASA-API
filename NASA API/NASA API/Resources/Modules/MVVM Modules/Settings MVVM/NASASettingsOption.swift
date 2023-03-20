//
//  NASASettingsOption.swift
//  NASA API
//
//  Created by Марк Киричко on 12.03.2023.
//

import UIKit

enum NASASettingsOption: CaseIterable {
    case apiReference
    case viewAppCode
    
    var targetUrl: URL? {
        switch self {
        case .apiReference:
            return URL(string: "https://api.nasa.gov/")
            
        case .viewAppCode:
            return URL(string: "https://github.com/MarkKirichko2002/NASA-API")
        }
    }
    
    var displayTitle: String {
        switch self {
        case .apiReference:
            return "ссылка на API"
            
        case .viewAppCode:
            return "код приложения"
        }
    }
    
    var iconImage: UIImage? {
        switch self {
        case .apiReference:
            return UIImage(named: "NASA")
        
        case .viewAppCode:
            return UIImage(named: "EPIC")
        }
    }
    
}
