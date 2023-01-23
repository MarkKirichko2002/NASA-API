//
//  SplashScreenController.swift
//  NASA API
//
//  Created by Марк Киричко on 23.01.2023.
//

import UIKit

class SplashScreenController: UIViewController {
    
    private let animation = AnimationClass()
    
    @IBOutlet weak var Icon: UIImageView!
    @IBOutlet weak var TitleLabel: UILabel!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        animation.springImage(image: Icon)
        SplashScreen()
    }
    
    private func SplashScreen() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.TitleLabel.text = "NASA API"
            self.animation.springLabel(label: self.TitleLabel)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            if let controller = self.storyboard?.instantiateViewController(withIdentifier: "NASATabBarController") as? NASATabBarController {
                controller.modalTransitionStyle = .crossDissolve
                controller.modalPresentationStyle = .currentContext
                self.present(controller, animated: false, completion: nil)
            }
        }
    }
    
}
