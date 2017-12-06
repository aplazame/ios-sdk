//
//  AplazameSDK.swift
//  Aplazame-sdk
//
//  Created by Andres Brun Moreno on 11/09/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import UIKit

public enum AplazameAvailabilityStatus {
    case available
    case notAvailable
    case undefined
}

public struct AplazameSDK {
    public static var debugMode = false
    public static var version = 1.0
    static let apiManager = APIManager()

    public static func requestPresent(from viewController: UIViewController,
                                      checkout: Checkout,
                                      delegate: AplazameCheckoutDelegate,
                                      onPresent: @escaping () -> Void) {
        let aplazameVC = AplazameCheckoutViewController.create(with: checkout,
                                                               delegate: delegate,
                                                               onReady: { vc in
            viewController.present(vc, animated: true, completion: nil)
            onPresent()
        })
        aplazameVC.modalTransitionStyle = .crossDissolve
        aplazameVC.modalPresentationStyle = .overFullScreen
        aplazameVC.modalPresentationCapturesStatusBarAppearance = true
    }
    
    public static func checkAvailability(checkout: Checkout,
                                         callback: @escaping (AplazameAvailabilityStatus) -> Void) {
        apiManager.request(route: .checkAvailability(checkout.order),
                           token: checkout.merchant.config.accessToken) { (result) in
                            switch result {
                            case .success(let code, _):
                                callback(code == 200 ? .available : .notAvailable)
                            case .error:
                                callback(.undefined)
                            }
        }
    }
}
