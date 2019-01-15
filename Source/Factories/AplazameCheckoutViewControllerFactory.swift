import Foundation

extension AplazameCheckoutViewController {
    static func create(with checkout: String,
                       config: APZConfig,
                       delegate: APZPaymentContextDelegate,
                       onReady: @escaping OnReadyCheckout) -> AplazameCheckoutViewController {
        return AplazameCheckoutViewController(checkout: checkout,
                                              config: config,
                                              delegate: delegate,
                                              onReady: onReady)
    }
}
