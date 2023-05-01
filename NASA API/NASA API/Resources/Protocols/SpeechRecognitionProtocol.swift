//
//  SpeechRecognitionProtocol.swift
//  NASA API
//
//  Created by Марк Киричко on 22.04.2023.
//

import Foundation

protocol SpeechRecognitionProtocol {
    func startSpeechRecognition()
    func cancelSpeechRecognization()
    func registerSpeechRecognitionHandler(block: @escaping(String)->Void)
}
