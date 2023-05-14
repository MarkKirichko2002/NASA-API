//
//  RoundedImageView.swift
//  NASA API
//
//  Created by Марк Киричко on 19.09.2022.
//

import UIKit
import AVFoundation

class RoundedImageView: UIImageView {
    
    var sound = ""
    private let audioPlayer = AVAudioPlayer()
    
    override func layoutSubviews() {
        self.layer.cornerRadius = self.bounds.width / 2
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
        self.layer.borderWidth = 5
        self.layer.borderColor = UIColor.black.cgColor
        self.clipsToBounds = true
    }
    
    @IBAction func tapFunction(sender: UITapGestureRecognizer) {
        
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


