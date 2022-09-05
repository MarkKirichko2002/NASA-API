//
//  NASAVideoPlayerViewController.swift
//  NASA API
//
//  Created by Марк Киричко on 05.09.2022.
//

import UIKit
import AVKit

class NASAVideoPlayerViewController: UIViewController, AVPlayerViewControllerDelegate, VideoPlayerDelegate {
    
    var presenter = NASAPresenter()
    var json = ""
    var playerController = AVPlayerViewController()
    var video = ""
    
    @IBAction func PlayVideo(_ sender: UIButton) {
        guard let url = URL(string: self.video) else {return}
        let player = AVPlayer(url: url)
        playerController = AVPlayerViewController()
        playerController.player = player
        playerController.allowsPictureInPicturePlayback = true
        playerController.delegate = self
        playerController.player?.play()
        self.present(playerController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        print(json)
        presenter.ParseNASAVideo(json: self.json)
        presenter.SetVideoPlayerDelegate(videoplayer: self)
    }
    
    func PresentNASAVideo(video: String) {
        DispatchQueue.main.async {
            self.video = video
        }
    }
}
