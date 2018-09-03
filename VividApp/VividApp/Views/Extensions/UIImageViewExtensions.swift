//
//  UIImageViewExtensions.swift
//  VividApp
//
//  Created by Ivan Mejia on 9/3/18.
//  Copyright © 2018 ivanmejia. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImageAnimated(image: UIImage) {
        if image == self.image {
            return
        }

        let animation = CATransition()
        animation.duration = 0.3
        animation.type = kCATransitionFade
        layer.add(animation, forKey: "ImageFade")
        self.image = image
    }
}

