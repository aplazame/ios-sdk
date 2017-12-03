//
//  WebViewLoadingViewTests.swift
//  Aplazame-sdk
//
//  Created by Andres Brun Moreno on 06/11/2016.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import XCTest
@testable import AplazameSDK
import WebKit

class WebViewLoadingViewTests: XCTestCase {
    
    let sut = WebViewLoadingView()

    func testWebViewWasCorrectlyInitialised() {
        XCTAssertNotNil(sut.url)
    }
}
