//
//  iFrameCommunication.swift
//  Aplazame-sdk
//
//  Created by Andres Brun on 01/06/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import Foundation
import WebKit

let checkoutCallbackName = "checkout"

/*
 < event: checkout-ready
 < event: get-checkout-data
 > event: checkout-data.    data: <checkout_data>
 < event: status_change.    status: success | pending | ko
 < event: close.            result: success | pending | dismiss | ko
 */
enum CheckoutPostMessageType: String {
    case getCheckoutData = "get-checkout-data"
    case statusChange = "status-change"
    case checkoutReady = "checkout-ready"
    case close = "close"
}

public enum APZCheckoutCloseReason: String {
    case success = "success"
    case pending = "pending"
    case dismiss = "dismiss"
    case ko = "ko"
}

public enum APZCheckoutStatus: String {
    case pending = "pending"
    case success = "success"
    case ko = "ko"
}

extension AplazameCheckoutViewController: IFrameCommunicator {
    func send(checkout: APZCheckout, config: APZConfig) {
        let allInfoJSON = try! JSONSerialization.data(withJSONObject: checkout.record(with: config), options: JSONSerialization.WritingOptions(rawValue: 0))
        let allInfoJSONString = NSString(data: allInfoJSON, encoding: String.Encoding.utf8.rawValue)!.replacingOccurrences(of: "'", with: "\'")
        
        let exec = "window.postMessage({aplazame: 'checkout', event: 'checkout-data', data: \(allInfoJSONString)}, '*');"
        dPrint(exec)
        webView.evaluateJavaScript(exec) { (object, error) in
            dPrint("sendCheckout object \(String(describing: object)) error \(String(describing: error))")
        }
    }
}

