//
//  VideoPlayerViewController.swift
//  NASA API
//
//  Created by Марк Киричко on 02.05.2023.
//

import UIKit

final class VideoPlayerViewController: UIViewController {
    
    var video = ""
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
}
