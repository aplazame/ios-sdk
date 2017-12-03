//
//  CheckoutMessagesHandler.swift
//  Aplazame-sdk
//
//  Created by Andres Brun Moreno on 05/06/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import Foundation

class CheckoutMessagesHandler: PostMessageHandler {
    let delegate: AplazameCheckoutDelegate
    let close: () -> Void
    let iFrameCommunicator: IFrameCommunicator
    let checkout: Checkout
    
    var callbackName: String { return checkoutCallbackName }
    
    init(delegate: AplazameCheckoutDelegate, iFrameCommunicator: IFrameCommunicator, checkout: Checkout, close: @escaping () -> Void) {
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
        case .Merchant:
            handleMerchanEvent()
        case .Success, .Confirm:
            handleConfirmTokenEvent(body["data"] as? String)
            close()
        case .Close:
            handleCloseEvent(with: body["result"] as? String)
            close()
        }
    }
    
    private func handleMerchanEvent() {
        dPrint("Merchant event received")
        iFrameCommunicator.send(checkout: checkout)
    }
    
    private func handleConfirmTokenEvent(_ token: String?) {
        guard let token = token else {
            dPrint("Confirm/ success event should come with a token")
            return
        }
        dPrint("Success event received \(token)")
        delegate.checkoutHandle(checkoutToken: token) { [weak self] (success) in
            self?.iFrameCommunicator.sendTokenConfirmation(with: success)
        }
    }
    
    private func handleCloseEvent(with result: String?) {
        guard let result = result else {
            dPrint("Result should contains the reason why iFrame is being closing")
            return
        }
        let closeReason = CheckoutCloseReason(rawValue: result)
        dPrint("Close event received \(String(describing: closeReason))")
        
        switch closeReason {
        case .Dismiss?: delegate.checkoutDidCancel()
        case .Success?: delegate.checkoutDidSuccess()
        case .Cancel?: delegate.checkoutDidCancel()
        default: dPrint("Unhandled close reason \(result)")
        }
    }
}
