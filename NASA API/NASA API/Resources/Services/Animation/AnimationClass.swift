//
//  AnimationClass.swift
//  NASA API
//
//  Created by Марк Киричко on 17.01.2023.
//

import UIKit

class AnimationClass: AnimationClassProtocol {
    
    private let rotationAnimation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
    
    func SpringAnimation<T: UIView>(view: T) {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0
        animation.toValue = 1
        animation.stiffness = 300
        animation.mass = 1
        animation.duration = 0.5
        animation.beginTime = CACurrentMediaTime() + 0
        view.layer.add(animation, forKey: nil)
    }
    
    func StartRotateImage(image: UIImageView) {
        rotationAnimation.toValue = NSNumber(value: .pi * 2.0)
        rotationAnimation.duration = 2.0;
        rotationAnimation.isCumulative = true;
        rotationAnimation.repeatCount = .infinity;
        image.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    func StopRotateImage(image: UIImageView) {
        image.layer.removeAnimation(forKey: "rotationAnimation")
    }
    
    func TabBarItemAnimation(item: UITabBarItem) {
        guard let barItemView = item.value(forKey: "view") as? UIView else { return }
        
        let timeInterval: TimeInterval = 0.3
        let propertyAnimator = UIViewPropertyAnimator(duration: timeInterval, dampingRatio: 1.5) {
            barItemView.transform = CGAffineTransform.identity.scaledBy(x: 1.5, y: 1.5)
        }
        propertyAnimator.addAnimations({ barItemView.transform = .identity }, delayFactor: CGFloat(timeInterval))
        propertyAnimator.startAnimation()
    }
    
    func FlipAnimation<T: UIView>(view: T) {
        T.transition(with: view, duration: 0.4,
                     options: .transitionFlipFromRight, animations: nil,
                     completion: nil)
    }
}
