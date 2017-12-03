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

enum CheckoutPostMessageType: String {
    case Merchant = "merchant"
    case Success = "success"
    case Confirm = "confirm"
    case Close = "close"
}

enum CheckoutCloseReason: String {
    case Dismiss = "dismiss"
    case Success = "success"
    case Cancel = "cancel"
}

extension AplazameCheckoutViewController: IFrameCommunicator {
    func send(checkout: Checkout) {
        let allInfoJSON = try! JSONSerialization.data(withJSONObject: checkout.record, options: JSONSerialization.WritingOptions(rawValue: 0))
        let allInfoJSONString = NSString(data: allInfoJSON, encoding: String.Encoding.utf8.rawValue)!.replacingOccurrences(of: "'", with: "\'")
        
        let exec = "parent.window.postMessage({aplazame: 'checkout', checkout: \(allInfoJSONString)}, '*');"
        dPrint(exec)
        webView.evaluateJavaScript(exec) { (object, error) in
            dPrint("sendCheckout object \(String(describing: object)) error \(String(describing: error))")
        }
    }
    
    func sendTokenConfirmation(with success: Bool) {
        let exec = "parent.window.postMessage({aplazame: 'checkout', event: 'confirmation', result: '\(success.apiRecordString)'}, '*');"
        dPrint(exec)
        webView.evaluateJavaScript(exec) { (object, error) in
            dPrint("sendTokenConfirmation object \(String(describing: object)) error \(String(describing: error))")
        }
    }
}

private extension Bool {
    var apiRecordString: String {
        return self ? "success" : "error"
    }
}
