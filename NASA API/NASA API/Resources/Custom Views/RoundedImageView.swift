//
//  RoundedImageView.swift
//  NASA API
//
//  Created by Марк Киричко on 19.09.2022.
//

import UIKit

class RoundedImageView: UIImageView {
    
    var sound = ""
    
    override func layoutSubviews() {
        let interaction = UIContextMenuInteraction(delegate: self)
        self.addInteraction(interaction)
        self.layer.cornerRadius = self.bounds.width / 2
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
        self.layer.borderWidth = 5
        self.layer.borderColor = UIColor.black.cgColor
        self.clipsToBounds = true
    }
    
    func SaveImage() {
        guard let inputImage = self.image else { return }
        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: inputImage)
    }
    
    @objc private func tapFunction(sender: UITapGestureRecognizer) {
        
        AudioPlayer.shared.PlaySound(resource: sound)
        
        UIView.animate(withDuration: 0.75,
                       delay: 0,
                       usingSpringWithDamping: 0.50,
                       initialSpringVelocity: 0.50,
                       options: [.allowUserInteraction],
                       animations: {
            self.bounds = self.bounds.insetBy(dx: 15, dy: 15)
        },
                       completion: nil)
    }
}

// MARK: - UIContextMenuInteractionDelegate
extension RoundedImageView: UIContextMenuInteractionDelegate {
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil,
                                          previewProvider: nil,
                                          actionProvider: {
            suggestedActions in
            let saveImage =
            UIAction(title: NSLocalizedString("cохранить", comment: ""),
                     image: UIImage(systemName: "photo")) { action in
                self.SaveImage()
            }
            
            return UIMenu(title: "", children: [saveImage])
        })
    }
}
