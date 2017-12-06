//
//  CheckoutMessagesHandler.swift
//  Aplazame-sdk
//
//  Created by Andres Brun Moreno on 05/06/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import Foundation

protocol CheckoutMessagesHandlerDelegate: class {
    func checkoutReady()
    func checkoutStatusChanged(with status: CheckoutStatus)
    func checkoutFinished(with reason: CheckoutCloseReason)
}

class CheckoutMessagesHandler: PostMessageHandler {
    unowned let delegate: CheckoutMessagesHandlerDelegate
    let close: () -> Void
    let iFrameCommunicator: IFrameCommunicator
    let checkout: Checkout
    
    var callbackName: String { return checkoutCallbackName }
    
    init(delegate: CheckoutMessagesHandlerDelegate,
         iFrameCommunicator: IFrameCommunicator,
         checkout: Checkout,
         close: @escaping () -> Void) {
        self.delegate = delegate
        self.iFrameCommunicator = iFrameCommunicator
        self.close = close
        self.checkout = checkout
    }
    
    func handle(receivedMessage message: ScriptMessageType) {
        guard message.name == checkoutCallbackName else {
            dPrint("Unrecognizer message \(message.name)")
            return
        }
        
        guard let body = message.bodyRecord else {
            dPrint("Message should provide a body of type Dictionary")
            return
        }
        
        guard let postMessageType = CheckoutPostMessageType(rawValue: body["event"] as! String) else {
            dPrint("Unhandled event \(body)")
            return
        }
        
        switch postMessageType {
        case .getCheckoutData:
            handleCheckoutEvent()
        case .checkoutReady:
            delegate.checkoutReady()
        case .statusChange:
            handleStatusChange(body["status"] as? String)
        case .close:
            handleCloseEvent(with: body["result"] as? String)
            close()
        }
    }
    
    private func handleCheckoutEvent() {
        dPrint("Merchant event received")
        iFrameCommunicator.send(checkout: checkout)
    }
    
    private func handleStatusChange(_ rawStatus: String?) {
        guard let rawStatus = rawStatus,
            let status = CheckoutStatus(rawValue: rawStatus)
            else {
            dPrint("Status change should come with a valid a reason")
            return
        }
        dPrint("New Status: \(status)")
        delegate.checkoutStatusChanged(with: status)
    }
    
    private func handleCloseEvent(with result: String?) {
        guard let result = result else {
            dPrint("Result should contains the reason why iFrame is being closing")
            return
        }
        let closeReason = CheckoutCloseReason(rawValue: result)
        dPrint("Close event received \(String(describing: closeReason))")
        
        if let closeReason = closeReason {
            delegate.checkoutFinished(with: closeReason)
        } else {
            dPrint("Unhandled close reason \(result)")
        }
    }
}
