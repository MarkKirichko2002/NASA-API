//
//  DateManager.swift
//  NASA API
//
//  Created by Марк Киричко on 16.04.2023.
//

import Foundation

class DateManager: DateManagerProtocol {
    
    func GetCurrentDate()->String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        let string = formatter.string(from: date)
        return string
    }
    
    private var dataChangedHandler: ((String)->Void)?
    
    func registerDataChangedHandler(block: @escaping(String)->Void) {
        self.dataChangedHandler = block
    }
}
