//
//  TextRecognitionManagerProtocol.swift
//  NASA API
//
//  Created by Марк Киричко on 20.06.2023.
//

import UIKit

protocol TextRecognitionManagerProtocol {
    func recognizeText(image: UIImage,completion: @escaping(String)->())
}
