//
//  NASAImageDetailViewController.swift
//  NASA API
//
//  Created by Марк Киричко on 31.08.2022.
//

import UIKit
import SDWebImage

class NASAImageDetailViewController: UIViewController {
    
    @IBOutlet var text: UITextView!
    @IBOutlet var NASAImageDetail: RoundedImageView!
    var info: String?
    var image: String?
    var sound: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        text.text = info
        text.isEditable = false
        NASAImageDetail.sd_setImage(with: URL(string: image ?? ""))
        NASAImageDetail.sound = sound ?? ""
    }
}
