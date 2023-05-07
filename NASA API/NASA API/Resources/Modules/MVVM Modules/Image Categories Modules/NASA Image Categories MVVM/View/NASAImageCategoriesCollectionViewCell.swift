//
//  NASAImageCategoriesCollectionViewCell.swift
//  NASA API
//
//  Created by Марк Киричко on 23.01.2023.
//

import UIKit
import SDWebImage

final class NASAImageCategoriesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "NASAImageCategoriesCollectionViewCell"
    
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
    
    private let ItemsCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(imageView,nameLabel,ItemsCountLabel)
        addConstaints()
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
    
    private func addConstaints() {
        NSLayoutConstraint.activate([
            // изображение категории
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -3),
            // название категории
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
            nameLabel.bottomAnchor.constraint(equalTo: ItemsCountLabel.topAnchor),
            // количество изображений
            ItemsCountLabel.heightAnchor.constraint(equalToConstant: 30),
            ItemsCountLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
            ItemsCountLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
            ItemsCountLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setUpLayer()
    }
    
    public func configure(with viewModel: NASAImageCategoriesCollectionViewCellViewModel) {
        imageView.sd_setImage(with: URL(string: viewModel.categoryImage)) 
        nameLabel.text = viewModel.categoryName
        ItemsCountLabel.text = "изображений: \(viewModel.imagesCount)"
    }
}
