//
//  UIButtonExtension.swift
//  Aplazame-ios-sdk-demo
//
//  Created by Andres Brun on 01/06/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import UIKit

extension UIButton {
    func moveIconToRight() {
        transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    }
}
