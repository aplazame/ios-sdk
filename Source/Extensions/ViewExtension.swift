//
//  ViewExtension.swift
//  Aplazame-sdk
//
//  Created by Andres Brun Moreno on 06/05/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import UIKit

extension UIView {
    func addConstraintsToFillInSuperview() {
        guard let superview = superview else { return }
        let noLayoutFormatOptions = NSLayoutFormatOptions(rawValue: 0)
        translatesAutoresizingMaskIntoConstraints = false
        superview.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:|[view]|",
                options: noLayoutFormatOptions,
                metrics: nil,
                views: ["view": self]))
        superview.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|[view]|",
                options: noLayoutFormatOptions,
                metrics: nil,
                views: ["view": self]))
    }
}
