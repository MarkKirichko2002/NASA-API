//
//  MarsRoverImagesTableViewCell.swift
//  NASA API
//
//  Created by Марк Киричко on 11.08.2022.
//

import UIKit

class NasaImagesTableViewCell: UITableViewCell {

    static let identifier = "NasaImagesTableViewCell"
    
    @IBOutlet weak var NASAImage: UIImageView!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!

}
