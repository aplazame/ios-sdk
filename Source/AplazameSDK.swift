//
//  AplazameSDK.swift
//  Aplazame-sdk
//
//  Created by Andres Brun Moreno on 11/09/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import UIKit

public struct AplazameSDK {
    public static var debugMode = false
    public static var version = 1.0

    public static func present(from viewController: UIViewController, checkout: Checkout, delegate: AplazameCheckoutDelegate) {
        let aplazameVC = AplazameCheckoutViewController.create(checkout, delegate: delegate)

        aplazameVC.modalTransitionStyle = .crossDissolve
        aplazameVC.modalPresentationStyle = .overFullScreen
        aplazameVC.modalPresentationCapturesStatusBarAppearance = true
        
        viewController.definesPresentationContext = true
        viewController.present(aplazameVC, animated: true, completion: nil)
    }
}
