import WebKit

final class WebViewContainerView: WKWebView {
    fileprivate let postMessageHandlers: [PostMessageHandler]
    
    init(postMessageHandlers: [PostMessageHandler]) {
        self.postMessageHandlers = postMessageHandlers
        
        let userContentController = WKUserContentController()
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController
        
        super.init(frame: .zero, configuration: configuration)
        
        postMessageHandlers.forEach { (postMessageHandler) in
            userContentController.add(self, name: postMessageHandler.callbackName)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WebViewContainerView: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        postMessageHandlers
            .filter { $0.callbackName == message.name }
            .forEach { postMessageHandler in
                postMessageHandler.handle(receivedMessage: message)
        }
    }
}

extension WKScriptMessage: ScriptMessageType {
    var bodyRecord: [String: Any]? {
        return body as? [String: Any]
    }
}
