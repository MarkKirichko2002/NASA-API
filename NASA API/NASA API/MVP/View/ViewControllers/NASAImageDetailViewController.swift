//
//  NASAImageDetailViewController.swift
//  NASA API
//
//  Created by Марк Киричко on 31.08.2022.
//

import UIKit
import SDWebImage

class NASAImageDetailViewController: UIViewController {

    @IBOutlet var text: UILabel!
    @IBOutlet var NASAImageDetail: UIImageView!
    var info: String?
    var image: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        text.text = info
        NASAImageDetail.sd_setImage(with: URL(string: image ?? ""))
        NASAImageDetail.layer.cornerRadius = NASAImageDetail.frame.width / 2
        NASAImageDetail.layer.borderWidth = 5
    }
    
}
