//
//  NASAEPICImagesCollectionViewCell.swift
//  NASA API
//
//  Created by Марк Киричко on 24.01.2023.
//

import UIKit
import SDWebImage

final class NASAEPICImagesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "NASAEPICImagesCollectionViewCell"
    
    private let imageView: UIImageView = {
       let imageView = UIImageView()
       imageView.contentMode = .scaleAspectFill
       imageView.clipsToBounds = true
       imageView.translatesAutoresizingMaskIntoConstraints = false
       return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(imageView,nameLabel,dateLabel)
        addConstraints()
        setUpLayer()
    }
    
    required init(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func setUpLayer() {
        contentView.layer.cornerRadius = 8
        contentView.layer.shadowColor = UIColor.label.cgColor
        contentView.layer.cornerRadius = 4
        contentView.layer.shadowOffset = CGSize(width: -4, height: -4)
        contentView.layer.shadowOpacity = 0.3
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            // изображение земли
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor),
            // название 
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
            nameLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor),
            // дата
            dateLabel.heightAnchor.constraint(equalToConstant: 30),
            dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
            dateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setUpLayer()
    }
   
    public func configure(with viewModel: NASAEPICImagesCollectionViewCellViewModel) {
        imageView.sd_setImage(with: URL(string: viewModel.EPICIMage))
        nameLabel.text = viewModel.EPICTitle
        dateLabel.text = viewModel.EPICDate
    }
    
}
