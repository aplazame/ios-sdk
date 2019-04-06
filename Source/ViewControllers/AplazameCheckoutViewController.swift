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
    fileprivate let checkout: String
    fileprivate let config: APZConfig
    
    fileprivate lazy var checkoutMasegeHandler: CheckoutMessagesHandler = self.createPostMessageHandler()
    lazy var webView: WebViewContainerView = WebViewContainerView(postMessageHandlers: [self.checkoutMasegeHandler])
    
    init(checkout: String,
         config: APZConfig,
         delegate: APZPaymentContextDelegate,
         onReady: @escaping OnReadyCheckout) {
        self.checkout = checkout
        self.config = config
        self.delegate = delegate
        self.onReady = onReady
        
        super.init(nibName: nil, bundle: nil)
        
        loadWebView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Aplazame SDK doesn't support be initialised with Xib/ Storyboard")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addWebView()
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
        let request = URLRequest(url: Router.checkout(config).url)
        webView.navigationDelegate = self
        webView.load(request)
    }
    
    fileprivate func createPostMessageHandler() -> CheckoutMessagesHandler {
        return CheckoutMessagesHandler(delegate: self,
                                       iFrameCommunicator: self,
                                       checkout: checkout) { [unowned self] in
            self.dismiss(animated: true, completion: nil)
        }
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
