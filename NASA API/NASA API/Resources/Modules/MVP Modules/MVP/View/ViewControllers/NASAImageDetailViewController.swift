//
//  NASAImageDetailViewController.swift
//  NASA API
//
//  Created by Марк Киричко on 31.08.2022.
//

import UIKit
import SDWebImage

class NASAImageDetailViewController: UIViewController {
    
    var info: String?
    var image: String?
    var sound: String?
    
    private let NASADetailImage: RoundedImageView = {
        let imageView = RoundedImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let DetailText: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 14, weight: .bold)
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubviews(NASADetailImage,DetailText)
        SetUpConstraints()
        DetailText.text = info
        NASADetailImage.sd_setImage(with: URL(string: image ?? ""))
        NASADetailImage.sound = sound ?? ""
    }
    
    
    private func SetUpConstraints() {
        NSLayoutConstraint.activate([
            NASADetailImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            NASADetailImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            NASADetailImage.heightAnchor.constraint(equalToConstant: 200),
            NASADetailImage.widthAnchor.constraint(equalToConstant: 200),
                        
            DetailText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            DetailText.heightAnchor.constraint(equalToConstant: 320),
            DetailText.topAnchor.constraint(equalTo: NASADetailImage.bottomAnchor, constant: 20),
            DetailText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            DetailText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            DetailText.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
