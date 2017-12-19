//
//  AplazameCheckoutViewControllerFactory.swift
//  Aplazame-sdk
//
//  Created by Andres Brun on 15/05/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import Foundation

extension AplazameCheckoutViewController {
    static func create(with checkout: APZCheckout,
                       config: APZConfig,
                       delegate: APZPaymentContextDelegate,
                       onReady: @escaping OnReadyCheckout) -> AplazameCheckoutViewController {
        return AplazameCheckoutViewController(checkout: checkout,
                                              config: config,
                                              delegate: delegate,
                                              onReady: onReady)
    }
}
