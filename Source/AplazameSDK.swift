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
    public static var version = 1.0
    public static var debugMode = false
}

public struct APZPaymentContext {
    fileprivate let apiManager = APIManager()
    /**
     config object to define environment information
     */
    fileprivate let config: APZConfig
    
    public init(config: APZConfig) {
        self.config = config
    }
    
    @discardableResult
    public func requestCheckout(checkout: APZCheckout,
                                delegate: APZPaymentContextDelegate,
                                onReady: @escaping (UIViewController) -> Void) -> UIViewController {
        return AplazameCheckoutViewController.create(with: checkout,
                                                     config: config,
                                                     delegate: delegate,
                                                     onReady: onReady)
    }
    
    public func requestCheckout(from viewController: UIViewController,
                                checkout: APZCheckout,
                                delegate: APZPaymentContextDelegate,
                                onPresent: @escaping () -> Void) {
        let aplazameVC = AplazameCheckoutViewController.create(with: checkout,
                                                               config: config,
                                                               delegate: delegate,
                                                               onReady: { vc in
                                                                viewController.present(vc,
                                                                                       animated: true,
                                                                                       completion: nil)
                                                                onPresent()
        })
        aplazameVC.modalTransitionStyle = .crossDissolve
        aplazameVC.modalPresentationStyle = .overFullScreen
        aplazameVC.modalPresentationCapturesStatusBarAppearance = true
    }
    
    public func checkAvailability(amount: Int,
                                  currency: String,
                                  callback: @escaping (AplazameAvailabilityStatus) -> Void) {
        apiManager.request(route: .checkAvailability(amount, currency),
                           token: config.accessToken) { (result) in
                            switch result {
                            case .success(let code, _):
                                callback(code == 200 ? .available : .notAvailable)
                            case .error:
                                callback(.undefined)
                            }
        }
    }
}
