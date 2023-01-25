//
//  APODViewController.swift
//  NASA API
//
//  Created by Марк Киричко on 25.01.2023.
//

import UIKit
import SDWebImage

class APODViewController: UIViewController {
    
    private let presenter = APODPresenter()
    
    private let imageView: RoundedImageView = {
        let imageView = RoundedImageView()
        imageView.sound = "space.wav"
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let DateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ExplanationTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 14, weight: .bold)
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(imageView, DateLabel, ExplanationTextView)
        SetUpConstraints()
        presenter.SetViewDelegate(delegate: self)
        presenter.GetAPOD()
    }
    
    private func SetUpConstraints() {
        NSLayoutConstraint.activate([
            // изображение
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 250),
            imageView.heightAnchor.constraint(equalToConstant: 250),
            // дата
            DateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            DateLabel.heightAnchor.constraint(equalToConstant: 30),
            DateLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
            DateLabel.bottomAnchor.constraint(equalTo: ExplanationTextView.topAnchor),
            // описание
            ExplanationTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ExplanationTextView.heightAnchor.constraint(equalToConstant: 320),
            ExplanationTextView.topAnchor.constraint(equalTo: DateLabel.bottomAnchor, constant: 15),
            ExplanationTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            ExplanationTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            ExplanationTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension APODViewController: APODPresentDelegate {
    
    func PresentAPOD(apod: Apod) {
        imageView.sd_setImage(with: URL(string: apod.hdurl))
        DispatchQueue.main.async {
            self.DateLabel.text = apod.date
            self.ExplanationTextView.text = apod.explanation
        }
    }
}
