//
//  UIView + Extensions.swift
//  NASA API
//
//  Created by Марк Киричко on 23.01.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach ({
           addSubview($0)
        })
    }
}
