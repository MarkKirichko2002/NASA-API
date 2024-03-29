//
//  APODViewController.swift
//  Super easy dev
//
//  Created by Марк Киричко on 15.05.2023
//

import UIKit

protocol APODViewProtocol: AnyObject {
    func displayAPOD(apod: Apod)
}

class APODViewController: UIViewController {
    
    var presenter: APODPresenterProtocol?

    private func openCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    private func openPhotoLibrary() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    let imageView: RoundedImageView = {
        let imageView = RoundedImageView()
        imageView.sound = "space.wav"
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let DateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ExplanationTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 14, weight: .bold)
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getAPOD()
        view.backgroundColor = .systemBackground
        view.addSubviews(imageView, DateLabel, ExplanationTextView)
        SetUpConstraints()
        SetUpNavigation()
        NotificationCenter.default.addObserver(forName: Notification.Name("DateWasSelected"), object: nil, queue: .main) { notification in
            if let date = notification.object as? String {
                self.presenter?.getAPODWithOtherDate(date: date)
            }
        }
    }
 
    private func SetUpNavigation() {
        let camera = UIAction(title: "камера", image: UIImage(systemName: "camera")) { _ in
            DispatchQueue.main.async {
                self.openCamera()
            }
        }
        let photoLibrary = UIAction(title: "фото", image: UIImage(systemName: "photo")) { _ in
            DispatchQueue.main.async {
                self.openPhotoLibrary()
            }
        }
        let calendar = UIAction(title: "календарь", image: UIImage(systemName: "calendar")) { _ in
            DispatchQueue.main.async {
                self.presenter?.openCalendar()
            }
        }
        let menu = UIMenu(title: "изменить дату", children: [camera, photoLibrary, calendar])
        let media = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), menu: menu)
        media.tintColor = .black
        navigationItem.rightBarButtonItem = media
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
