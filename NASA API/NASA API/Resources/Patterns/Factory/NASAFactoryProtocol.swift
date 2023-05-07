//
//  NASAFactoryProtocol.swift
//  NASA API
//
//  Created by Марк Киричко on 07.05.2023.
//

import UIKit

protocol NASAScreenFactoryProtocol {
    func createNASAImageCategoriesViews(view: ImageCategoriesView, viewController: UIViewController & AnyObject)-> UIView
    func createImageCategoriesScreens(screen: ImageCategoriesScreen)-> UIViewController
}
