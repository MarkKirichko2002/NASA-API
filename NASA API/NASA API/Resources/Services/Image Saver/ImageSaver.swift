//
//  ImageSaver.swift
//  NASA API
//
//  Created by Марк Киричко on 05.06.2023.
//

import UIKit

class ImageSaver: NSObject, ImageSaverProtocol {
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }

    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
}
