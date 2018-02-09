import WebKit

final class WebViewLoadingView: WKWebView {
    init() {
        super.init(frame: .zero, configuration: WKWebViewConfiguration())
        makeItTransparent()

        let path = Bundle(for: type(of: self)).path(forResource: "loading", ofType: "html")
        load(URLRequest(url: URL(fileURLWithPath: path!)))        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
