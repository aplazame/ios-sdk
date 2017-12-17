//
//  AplazameCheckoutViewController.swift
//  Aplazame-sdk
//
//  Created by Andres Brun Moreno on 05/05/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import UIKit
import WebKit

public protocol APZPaymentContextDelegate: class {
    func checkoutStatusChanged(with status: APZCheckoutStatus)
    func checkoutDidClose(checkoutVC: UIViewController, with reason: APZCheckoutCloseReason)
}

public extension APZPaymentContextDelegate {
    func checkoutStatusChanged(with status: APZCheckoutStatus) {}
}

typealias OnReadyCheckout = (AplazameCheckoutViewController) -> Void

class AplazameCheckoutViewController: UIViewController {
    
    fileprivate unowned let delegate: APZPaymentContextDelegate
    fileprivate let onReady: OnReadyCheckout
    fileprivate let checkout: APZCheckout
    fileprivate let config: APZConfig
    fileprivate var previusStatusBarStyle: UIStatusBarStyle!
    
    fileprivate lazy var checkoutMasegeHandler: CheckoutMessagesHandler = self.createPostMessageHandler()
    lazy var webView: WebViewContainerView = WebViewContainerView(postMessageHandlers: [self.checkoutMasegeHandler])
    
    init(checkout: APZCheckout,
         config: APZConfig,
         delegate: APZPaymentContextDelegate,
         onReady: @escaping OnReadyCheckout) {
        self.checkout = checkout
        self.config = config
        self.delegate = delegate
        self.onReady = onReady
        
        super.init(nibName: nil, bundle: nil)
        
        makeItTransparent()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Aplazame SDK doesn't support be initialised with Xib/ Storyboard")
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
        return CheckoutMessagesHandler(delegate: self,
                                       iFrameCommunicator: self,
                                       checkout: checkout,
                                       config: config) { [unowned self] in
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

extension AplazameCheckoutViewController: CheckoutMessagesHandlerDelegate {
    func checkoutReady() {
        onReady(self)
    }
    
    func checkoutStatusChanged(with status: APZCheckoutStatus) {
        delegate.checkoutStatusChanged(with: status)
    }
    
    func checkoutDidClose(with reason: APZCheckoutCloseReason) {
        delegate.checkoutDidClose(checkoutVC: self, with: reason)
    }
}

extension AplazameCheckoutViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.navigationDelegate = nil
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        delegate.checkoutDidClose(checkoutVC: self, with: .ko)
    }
}
