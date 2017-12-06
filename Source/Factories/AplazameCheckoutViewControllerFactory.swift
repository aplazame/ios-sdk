//
//  AplazameCheckoutViewControllerFactory.swift
//  Aplazame-sdk
//
//  Created by Andres Brun on 15/05/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import Foundation

extension AplazameCheckoutViewController {
    static func create(with checkout: Checkout,
                       delegate: AplazameCheckoutDelegate,
                       onReady: @escaping OnReadyCheckout) -> AplazameCheckoutViewController {
        return AplazameCheckoutViewController(checkout: checkout,
                                              delegate: delegate,
                                              onReady: onReady)
    }
}
