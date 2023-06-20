//
//  DateManagerProtocol.swift
//  NASA API
//
//  Created by Марк Киричко on 20.06.2023.
//

import Foundation

protocol DateManagerProtocol {
    func GetCurrentDate()->String
    func registerDataChangedHandler(block: @escaping(String)->Void)
}
