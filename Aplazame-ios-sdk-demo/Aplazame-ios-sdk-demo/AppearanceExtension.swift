//
//  AppearanceExtension.swift
//  Aplazame-ios-sdk-demo
//
//  Created by Andres Brun Moreno on 18/05/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import UIKit

extension UINavigationItem {
    func applyLogo() {
        titleView = UIImageView(image: UIImage(named: "logotipo-white"))
    }
}

extension UINavigationController {
    func applyStyle() {
        navigationBar.barTintColor = .aBlueColor()
        navigationBar.isTranslucent = false        
    }
}

extension UIColor {
    static func aBlueColor() -> UIColor {
        return UIColor(red: 38.0 / 255.0, green: 123.0 / 255.0, blue: 189.0 / 255.0, alpha: 1)
    }
}
