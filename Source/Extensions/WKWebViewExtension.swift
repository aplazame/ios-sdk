//
//  WKWebViewExtension.swift
//  Aplazame-sdk
//
//  Created by Andres Brun Moreno on 30/09/2016.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import WebKit

extension WKWebView {
    func makeItTransparent() {
        backgroundColor = .clear
        scrollView.backgroundColor = .clear
        isOpaque = false
    }
}
