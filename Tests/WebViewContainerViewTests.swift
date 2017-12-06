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
    
    func testMessageHandlerReceiveReady() {
        delegate.checkoutReadyExpectation = expectation(description: "Should call ready")
        
        sut.simulateCheckoutReadyPostMessage()
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testMessageHandlerReceiveSuccess() {
        delegate.checkoutSuccessExpectation = expectation(description: "Should call success")
        
        sut.simulateClosePostMessage(.success)
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testMessageHandlerReceiveCancel() {
        delegate.checkoutKoExpectation = expectation(description: "Should call Ko")
        
        sut.simulateClosePostMessage(.ko)
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}

extension WebViewContainerView {
    func simulateCheckoutMerchantPostMessage() {
        let scriptMessage = MockedScriptMessage(
            mockedName: checkoutCallbackName,
            mockedBody: ["event": CheckoutPostMessageType.getCheckoutData.rawValue])
        userContentController(configuration.userContentController, didReceive: scriptMessage)
    }
    
    func simulateCheckoutReadyPostMessage() {
        let scriptMessage = MockedScriptMessage(
            mockedName: checkoutCallbackName,
            mockedBody: ["event": CheckoutPostMessageType.checkoutReady.rawValue])
        userContentController(configuration.userContentController, didReceive: scriptMessage)
    }
    
    func simulateClosePostMessage(_ reason: CheckoutCloseReason) {
        let scriptMessage = MockedScriptMessage(
            mockedName: checkoutCallbackName,
            mockedBody: ["event": CheckoutPostMessageType.close.rawValue, "result": reason.rawValue])
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

class MockedDelegate: CheckoutMessagesHandlerDelegate {
    
    var checkoutReadyExpectation: XCTestExpectation?
    var checkoutSuccessExpectation: XCTestExpectation?
    var checkoutKoExpectation: XCTestExpectation?
    var checkoutPendingExpectation: XCTestExpectation?
    
    func checkoutReady() {
        checkoutReadyExpectation?.fulfill()
    }
    
    func checkoutFinished(with reason: CheckoutCloseReason) {
        switch reason {
        case .dismiss, .success:
            checkoutSuccessExpectation?.fulfill()
        case .ko:
            checkoutKoExpectation?.fulfill()
        case .pending:
            checkoutPendingExpectation?.fulfill()
        }
    }
    
    func checkoutStatusChanged(with status: CheckoutStatus) { }
}

class MockedIFrameCommunicator: IFrameCommunicator {

    var sendCheckoutExpectation: XCTestExpectation?

    func send(checkout: Checkout) {
        sendCheckoutExpectation?.fulfill()
    }
}
