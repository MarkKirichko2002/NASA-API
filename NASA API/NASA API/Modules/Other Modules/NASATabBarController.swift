//
//  NASATabBarController.swift
//  NASA API
//
//  Created by Марк Киричко on 17.01.2023.
//

import UIKit

class NASATabBarController: UITabBarController {
    
    private let animation = AnimationClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        animation.TabBarItemAnimation(item: item)
    }
    
}
