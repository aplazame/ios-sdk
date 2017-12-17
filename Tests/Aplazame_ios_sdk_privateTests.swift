//
//  Aplazame_ios_sdk_privateTests.swift
//  Aplazame-sdkTests
//
//  Created by Andres Brun Moreno on 05/05/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import XCTest
@testable import AplazameSDK

class AplazameCheckoutViewControllerTests: XCTestCase {
    
    fileprivate let delegate = DummyCheckoutViewControllerDelegate()
    fileprivate var checkoutVC: AplazameCheckoutViewController!
    fileprivate let basicConfig = APZConfig.createBasicConfig()

    override func setUp() {
        super.setUp()
        checkoutVC = AplazameCheckoutViewController.create(with: .createRandomCheckout(),
                                                           config: basicConfig,
                                                           delegate: delegate,
                                                           onReady: { _ in })
        checkoutVC.simulateAppearance()
    }
    
    func testContainsWebView() {
        XCTAssertTrue((checkoutVC.view.subviews.contains { $0 is WebViewContainerView }), "It should contains webview")
    }
}


class DummyCheckoutViewControllerDelegate: APZPaymentContextDelegate {
    func checkoutDidClose(checkoutVC: UIViewController, with reason: APZCheckoutCloseReason) {}
}

extension AplazameCheckoutViewController {
    func simulateAppearance() {
        beginAppearanceTransition(true, animated: false)
        endAppearanceTransition()
    }
}

extension NSError {
    static func createRandomError() -> NSError {
        return NSError(domain: "own", code: 500, userInfo: nil)
    }
}
