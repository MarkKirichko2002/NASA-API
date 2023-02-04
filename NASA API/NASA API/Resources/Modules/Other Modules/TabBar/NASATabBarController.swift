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
        UITabBar.appearance().tintColor = UIColor.black
        view.backgroundColor = .white
        SetUpTabs()
    }
    
    private func SetUpTabs() {
        
        let imageCategoriesVC = NASAImageCategoriesListViewController()
        let asteroidsVC = AsteroidViewController()
        let mediaLibrary = NASAVideosTableViewController()
        let marsWeatherVC = MarsWeatherViewController()
        
        imageCategoriesVC.navigationItem.largeTitleDisplayMode = .automatic
        asteroidsVC.navigationItem.largeTitleDisplayMode = .automatic
        mediaLibrary.navigationItem.largeTitleDisplayMode = .automatic
        marsWeatherVC.navigationItem.largeTitleDisplayMode = .automatic
        
        let nav1 = UINavigationController(rootViewController: imageCategoriesVC)
        let nav2 = UINavigationController(rootViewController: asteroidsVC)
        let nav3 = UINavigationController(rootViewController: mediaLibrary)
        let nav4 = UINavigationController(rootViewController: marsWeatherVC)
        
        nav1.tabBarItem = UITabBarItem(title: "NASA Images", image: UIImage(named: "images"), selectedImage: UIImage(named: "images selected"))
        nav2.tabBarItem = UITabBarItem(title: "Asteroids", image: UIImage(named: "asteroids"), selectedImage: UIImage(named: "asteroids selected"))
        nav3.tabBarItem = UITabBarItem(title: "NASA Video Library", image: UIImage(named: "video player"), selectedImage: UIImage(named: "video player selected"))
        nav4.tabBarItem = UITabBarItem(title: "Mars Weather", image: UIImage(systemName: "cloud"), selectedImage: UIImage(systemName: "cloud.fill"))
               
        for nav in [nav1,nav2,nav3,nav4] {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers([nav1,nav2,nav3,nav4], animated: true)
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        animation.TabBarItemAnimation(item: item)
    }
}
