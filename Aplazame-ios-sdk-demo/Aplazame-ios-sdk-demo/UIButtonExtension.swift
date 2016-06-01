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
        transform = CGAffineTransformMakeScale(-1.0, 1.0)
        titleLabel?.transform = CGAffineTransformMakeScale(-1.0, 1.0)
        imageView?.transform = CGAffineTransformMakeScale(-1.0, 1.0)
    }
}