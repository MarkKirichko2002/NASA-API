//
//  NASAImageCategories.swift
//  NASA API
//
//  Created by Марк Киричко on 11.06.2023.
//

import Foundation

struct NASAImageCategories {
    
    static let categories = [
        NasaImageCategory(id: 1, name: "APOD", icon: "camera", sound: "space.wav", voiceCommand: "фото дня"),
        NasaImageCategory(id: 2, name: "Фото Марса", icon: "rover", sound: "space.wav", voiceCommand: "марс"),
        NasaImageCategory(id: 3, name: "NASA Изображения", icon: "NASA", sound: "camera.mp3", voiceCommand: "изображ"),
        NasaImageCategory(id: 4, name: "EPIC", icon: "EPIC", sound: "space.wav", voiceCommand: "земл"),
        NasaImageCategory(id: 5, name: "Земля", icon: "", sound: "space.wav", voiceCommand: "спутник")
    ]
}
