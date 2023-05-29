//
//  VideoPlayerViewController.swift
//  NASA API
//
//  Created by Марк Киричко on 02.05.2023.
//

import UIKit
import AVKit

final class VideoPlayerViewController: UIViewController, AVPlayerViewControllerDelegate {
    
    private var video = ""
    var json = ""
    private let nasaService = Injection.shared.makeContainer().resolve(NASAServiceProtocol.self)
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.setTitle("Воспроизвести Видео", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .black)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view?.backgroundColor = .systemBackground
        view.addSubview(playButton)
        playButton.addTarget(self, action: #selector(PlayVideo), for: .touchUpInside)
        makeConstraints()
        nasaService?.fetchVideo(json: self.json) { video in
            self.video = video
        }
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func PlayVideo() {
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
