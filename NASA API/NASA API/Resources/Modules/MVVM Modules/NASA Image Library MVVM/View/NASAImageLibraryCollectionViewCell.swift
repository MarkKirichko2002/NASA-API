//
//  NASAImageLibraryCollectionViewCell.swift
//  NASA API
//
//  Created by Марк Киричко on 26.01.2023.
//

import UIKit
import SDWebImage

class NASAImageLibraryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "NASAImageLibraryCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews(imageView,titleLabel)
        SetUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func SetUpConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor),
            
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with viewModel: NASAImageLibraryCollectionViewCellViewModel) {
        imageView.sd_setImage(with: URL(string: viewModel.NASAImage))
        titleLabel.text = viewModel.NASAImageTitle
    }
    
}
