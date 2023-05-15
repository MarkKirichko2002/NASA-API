//
//  APODViewController.swift
//  Super easy dev
//
//  Created by Марк Киричко on 15.05.2023
//

import UIKit
import SDWebImage

protocol APODViewProtocol: AnyObject {
    func displayAPOD(apod: Apod)
}

class APODViewController: UIViewController {
    
    var presenter: APODPresenterProtocol?
   
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
        view.backgroundColor = .systemBackground
        view.addSubviews(imageView, DateLabel, ExplanationTextView)
        SetUpConstraints()
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
            ExplanationTextView.heightAnchor.constraint(equalToConstant: 300),
            ExplanationTextView.topAnchor.constraint(equalTo: DateLabel.bottomAnchor, constant: 15),
            ExplanationTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            ExplanationTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            ExplanationTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

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
