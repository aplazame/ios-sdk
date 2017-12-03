//
//  AplazameCheckoutViewControllerFactory.swift
//  Aplazame-sdk
//
//  Created by Andres Brun on 15/05/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import Foundation

extension AplazameCheckoutViewController {
    static func create(_ checkout: Checkout, delegate: AplazameCheckoutDelegate) -> AplazameCheckoutViewController {
        return AplazameCheckoutViewController(checkout: checkout, delegate: delegate)
    }
}
