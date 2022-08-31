//
//  NASAImageDetailViewController.swift
//  NASA API
//
//  Created by Марк Киричко on 31.08.2022.
//

import UIKit

class NASAImageDetailViewController: UIViewController {

    @IBOutlet var text: UILabel!
    var info: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        text.text = info
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
