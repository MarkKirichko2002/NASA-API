//
//  MarsRoverImagesTableViewCell.swift
//  NASA API
//
//  Created by Марк Киричко on 11.08.2022.
//

import UIKit

class NasaImagesTableViewCell: UITableViewCell {
    
    static let identifier = "NasaImagesTableViewCell"
    
    let NASAImage: RoundedImageView = {
        let imageView = RoundedImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let TitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let DateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(NASAImage, TitleLabel, DateLabel)
        SetUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func SetUpConstraints() {
        NSLayoutConstraint.activate([
            NASAImage.topAnchor.constraint(equalTo: topAnchor),
            NASAImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            NASAImage.heightAnchor.constraint(equalToConstant: 100),
            NASAImage.widthAnchor.constraint(equalToConstant: 100),
            NASAImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            TitleLabel.topAnchor.constraint(equalTo: topAnchor),
            TitleLabel.leftAnchor.constraint(equalTo: NASAImage.leftAnchor, constant: 110),
            TitleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            DateLabel.topAnchor.constraint(equalTo: TitleLabel.bottomAnchor),
            DateLabel.leftAnchor.constraint(equalTo: NASAImage.leftAnchor, constant: 110),
            DateLabel.heightAnchor.constraint(equalToConstant: 30)
            
        ])
    }
}
