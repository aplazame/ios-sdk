import WebKit

extension WKWebView {
    func makeItTransparent() {
        backgroundColor = .clear
        scrollView.backgroundColor = .clear
        isOpaque = false
    }
}
