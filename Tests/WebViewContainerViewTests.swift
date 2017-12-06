//
//  WebViewContainerViewTests.swift
//  Aplazame-sdk
//
//  Created by Andres Brun Moreno on 05/06/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import XCTest
import WebKit
@testable import AplazameSDK

class WebViewContainerViewTests: XCTestCase {

    lazy var sut: WebViewContainerView = {
        return WebViewContainerView(postMessageHandlers: [self.checkoutMessageHandler])
    }()
    lazy var checkoutMessageHandler: CheckoutMessagesHandler = {
        return CheckoutMessagesHandler(delegate: self.delegate, iFrameCommunicator: self.iFrameCommunicator, checkout: .createRandomCheckout()) { }
    }()
        
    let delegate = MockedDelegate()
    let iFrameCommunicator = MockedIFrameCommunicator()

    func testMessageHandlerReceiveMerchantEvent_ShouldRequireCheckout() {
        iFrameCommunicator.sendCheckoutExpectation = expectation(description: "Should send checkout")
        
        sut.simulateCheckoutMerchantPostMessage()
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testMessageHandlerReceiveConfirmTokenEvent_ShouldSendConfirmToken() {
        iFrameCommunicator.sendTokenConfirmationExpectationSuccess = expectation(description: "Should require confirm token")
        delegate.checkoutHandleTokenExpectation = expectation(description: "Should send confirm token")
        
        sut.simulateConfirmTokenPostMessage()
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testMessageHandlerReceiveSuccess() {
        delegate.checkoutSuccessExpectation = expectation(description: "Should call success")
        
        sut.simulateClosePostMessage(.Success)
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testMessageHandlerReceiveCancel() {
        delegate.checkoutCancelExpectation = expectation(description: "Should call success")
        
        sut.simulateClosePostMessage(.Cancel)
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}

extension WebViewContainerView {
    func simulateCheckoutMerchantPostMessage() {
        let scriptMessage = MockedScriptMessage(
            mockedName: checkoutCallbackName,
            mockedBody: ["event": CheckoutPostMessageType.Merchant.rawValue])
        userContentController(configuration.userContentController, didReceive: scriptMessage)
    }
    
    func simulateConfirmTokenPostMessage() {
        let scriptMessage = MockedScriptMessage(
            mockedName: checkoutCallbackName,
            mockedBody: ["event": CheckoutPostMessageType.Confirm.rawValue, "data": "token"])
        userContentController(configuration.userContentController, didReceive: scriptMessage)
    }
    
    func simulateClosePostMessage(_ reason: CheckoutCloseReason) {
        let scriptMessage = MockedScriptMessage(
            mockedName: checkoutCallbackName,
            mockedBody: ["event": CheckoutPostMessageType.Close.rawValue, "result": reason.rawValue])
        userContentController(configuration.userContentController, didReceive: scriptMessage)
    }
}

class MockedScriptMessage: WKScriptMessage {
    let mockedName: String
    let mockedBody: APIRecordType
    
    override var name: String { return mockedName }
    override var body: Any { return mockedBody }
    
    init(mockedName: String, mockedBody: APIRecordType) {
        self.mockedName = mockedName
        self.mockedBody = mockedBody
    }
}

class MockedDelegate: AplazameCheckoutDelegate {
    var checkoutHandleTokenExpectation: XCTestExpectation?
    var checkoutSuccessExpectation: XCTestExpectation?
    var checkoutCancelExpectation: XCTestExpectation?
    
    
    func checkoutDidCancel() {
        checkoutCancelExpectation?.fulfill()
    }
   
    func checkoutDidSuccess() {
        checkoutSuccessExpectation?.fulfill()
    }
   
    func checkoutHandle(checkoutToken token: String, handler: (Bool) -> Void) {
        if !token.isEmpty {
            checkoutHandleTokenExpectation?.fulfill()
            handler(true)
        } else {
            handler(false)
        }
    }
   
    func checkoutFinished(with error: Error) {
        
    }
}

class MockedIFrameCommunicator: IFrameCommunicator {
    var sendTokenConfirmationExpectationSuccess: XCTestExpectation?
    var sendTokenConfirmationExpectationFailed: XCTestExpectation?
    var sendCheckoutExpectation: XCTestExpectation?
    
    func sendTokenConfirmation(with success: Bool) {
        if success {
            sendTokenConfirmationExpectationSuccess?.fulfill()
        } else {
            sendTokenConfirmationExpectationFailed?.fulfill()
        }
    }
    
    func send(checkout: Checkout) {
        sendCheckoutExpectation?.fulfill()
    }
}
