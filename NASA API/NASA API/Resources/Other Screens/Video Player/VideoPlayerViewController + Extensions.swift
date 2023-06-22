//
//  VideoPlayerViewController + Extensions.swift
//  NASA API
//
//  Created by Марк Киричко on 22.06.2023.
//

import AVKit

// MARK: - AVPlayerViewControllerDelegate
extension VideoPlayerViewController: AVPlayerViewControllerDelegate {
    
    @objc func PlayVideo() {
        var playerController = AVPlayerViewController()
        if let url = URL(string: self.video) {
            let player = AVPlayer(url: url)
            playerController = AVPlayerViewController()
            playerController.player = player
            playerController.allowsPictureInPicturePlayback = true
            playerController.delegate = self
            playerController.player?.play()
            self.present(playerController, animated: true, completion: nil)
        } else {}
    }
}
