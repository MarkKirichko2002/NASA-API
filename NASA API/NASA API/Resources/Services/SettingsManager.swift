//
//  SettingsManager.swift
//  NASA API
//
//  Created by Марк Киричко on 12.03.2023.
//

import Foundation

enum SettingsType: String {
    case livepreview
    case relaxmode
}

class SettingsManager {
    
  
    func loadSettingsData(key: String)-> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
    
    func writeSettingsData(value: Any, key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func CheckSettings(settingstype: SettingsType)-> Bool {
        if let data = self.loadSettingsData(key: settingstype.rawValue) as? Bool {
            return data
        }
        return false
    }
    
}
