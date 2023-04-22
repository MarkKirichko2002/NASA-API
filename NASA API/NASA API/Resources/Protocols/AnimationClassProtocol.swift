//
//  AnimationClassProtocol.swift
//  NASA API
//
//  Created by Марк Киричко on 22.04.2023.
//

import UIKit

protocol AnimationClassProtocol {
    func SpringAnimation<T: UIView>(view: T)
    func StartRotateImage(image: UIImageView)
    func StopRotateImage(image: UIImageView)
    func TabBarItemAnimation(item: UITabBarItem)
}
