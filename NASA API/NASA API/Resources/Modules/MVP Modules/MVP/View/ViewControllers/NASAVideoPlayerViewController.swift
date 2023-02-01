//
//  NASAVideoPlayerViewController.swift
//  NASA API
//
//  Created by Марк Киричко on 05.09.2022.
//

import UIKit
import AVKit

class NASAVideoPlayerViewController: UIViewController, AVPlayerViewControllerDelegate, VideoPlayerDelegate {
    
    private let presenter = NASAPresenter()
    private var playerController = AVPlayerViewController()
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.black
        button.tintColor = UIColor.white
        button.setTitle("Play Video", for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(NASAVideoPlayerViewController.self, action: #selector(PlayVideo), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    var video = ""
    var json = ""
    
    @objc private func PlayVideo() {
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
        view.addSubview(button)
        SetUpConstraints()
        presenter.ParseNASAVideo(json: self.json)
        presenter.SetVideoPlayerDelegate(videoplayer: self)
    }
    
    private func SetUpConstraints() {
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func PresentNASAVideo(video: String) {
        DispatchQueue.main.async {
            self.video = video
        }
    }
}
