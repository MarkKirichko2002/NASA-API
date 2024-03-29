//
//  AudioPlayerProtocol.swift
//  NASA API
//
//  Created by Марк Киричко on 22.04.2023.
//

import Foundation

protocol AudioPlayerProtocol {
    func PlaySound(resource: String)
    func StopSound(resource: String)
}
