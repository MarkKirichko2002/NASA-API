//
//  APODViewController + Extensions.swift
//  NASA API
//
//  Created by Марк Киричко on 22.06.2023.
//

import UIKit
import SDWebImage

// MARK: - APODViewProtocol
extension APODViewController: APODViewProtocol {
    
    func displayAPOD(apod: Apod) {
        self.imageView.sd_setImage(with: URL(string: apod.hdurl ?? ""), placeholderImage: UIImage(named: "NASA"))
        DispatchQueue.main.async {
            self.DateLabel.text = apod.date
            self.ExplanationTextView.text = apod.explanation
        }
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension APODViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        
        presenter?.recognizeText(image: image)
    }
}
