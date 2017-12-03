//
//  AplazameCheckoutViewController.swift
//  Aplazame-sdk
//
//  Created by Andres Brun Moreno on 05/05/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import UIKit
import WebKit

public protocol AplazameCheckoutDelegate: class {
    func checkoutReady()
    func checkoutStatusChanged(with status: CheckoutStatus)
    func checkoutFinished(with reason: CheckoutCloseReason)
}

public extension AplazameCheckoutDelegate {
    func checkoutStatusChanged(with status: CheckoutStatus) {}
}


class AplazameCheckoutViewController: UIViewController {
    
    fileprivate unowned let delegate: AplazameCheckoutDelegate
    fileprivate let checkout: Checkout
    fileprivate var previusStatusBarStyle: UIStatusBarStyle!
    
    fileprivate lazy var checkoutMasegeHandler: CheckoutMessagesHandler = self.createPostMessageHandler()
    lazy var webView: WebViewContainerView = WebViewContainerView(postMessageHandlers: [self.checkoutMasegeHandler])
    
    init(checkout: Checkout, delegate: AplazameCheckoutDelegate) {
        self.checkout = checkout
        self.delegate = delegate
        
        super.init(nibName: nil, bundle: nil)
        
        makeItTransparent()
    }

    required init?(coder aDecoder: NSCoder) {
        self.delegate = FakeAplazameCheckoutDelegate()
        self.checkout = .createFakeData()
        
        super.init(coder: aDecoder)
        assertionFailure("Aplazame SDK doesn't support be initialised with Xib/ Storyboard")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addWebView()
        
        loadWebView()
    }

    fileprivate func addWebView() {
        add(webView: webView)
    }

    fileprivate func add(webView webViewToAdd: WKWebView) {
        webViewToAdd.frame = view.bounds
        view.addSubview(webViewToAdd)
        webViewToAdd.addConstraintsToFillInSuperview()
    }
    
    fileprivate func loadWebView() {
        let request = URLRequest(url: Router.checkout.url)
        webView.navigationDelegate = self
        webView.load(request)
    }
    
    fileprivate func createPostMessageHandler() -> CheckoutMessagesHandler {
        return CheckoutMessagesHandler(delegate: delegate, iFrameCommunicator: self, checkout: checkout) { [unowned self] in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    fileprivate func makeItTransparent() {
        view.backgroundColor = .clear
        webView.makeItTransparent()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewWillAppear(_ animated: Bool) {
        previusStatusBarStyle = UIApplication.shared.statusBarStyle
        UIApplication.shared.statusBarStyle = preferredStatusBarStyle
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = previusStatusBarStyle
    }
}

extension AplazameCheckoutViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.navigationDelegate = nil
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        delegate.checkoutFinished(with: .ko)
        dismiss(animated: true, completion: nil)
    }
}

private class FakeAplazameCheckoutDelegate: AplazameCheckoutDelegate {
    func checkoutReady() {
        
    }
    
    func checkoutFinished(with reason: CheckoutCloseReason) {
        
    }
    
    func checkoutStatusChanged(with status: CheckoutStatus) {
        
    }
}

private extension Checkout {
    static func createFakeData() -> Checkout {
        return .create(.create("id", locale: .current, taxRate: 0, totalAmount: 0), config: Config(accessToken: "", environment: .sandbox))
    }
}
