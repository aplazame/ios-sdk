import UIKit
import AplazameSDK

final class ViewController: UIViewController {
    
    fileprivate lazy var checkout: APZCheckout = createCheckout()
    fileprivate var paymentContext: APZPaymentContext? {
        didSet {
            checkoutButton.set(enabled: paymentContext != nil)
        }
    }
    
    @IBOutlet weak var loadingView: UIView! {
        didSet {
            loadingView.isHidden = true
        }
    }
    @IBOutlet weak var checkoutButton: UIButton! {
        didSet {
            checkoutButton.moveIconToRight()
            checkoutButton.set(enabled: false)
        }
    }
    @IBOutlet weak var accessTokenTextField: UITextField!
    @IBAction func openCheckout(_ sender: AnyObject) {
        loadingView.isHidden = false
        paymentContext?.requestCheckout(checkout: checkout, delegate: self, onReady: { vc in
            self.loadingView.isHidden = true
            vc.title = "Aplazame"
            self.navigationController?.pushViewController(vc, animated: true)
        })
    }
    
    @IBAction func checkAvailability(_ sender: AnyObject) {
        guard let token = accessTokenTextField.text else { return }
        checkoutButton.set(enabled: false)
        paymentContext = APZPaymentContext(config: APZConfig(accessToken: token, environment: .sandbox))
        paymentContext?.checkAvailability(amount: checkout.order.totalAmount,
                                          currency: checkout.order.locale.currencyCode ?? "",
                                          callback: { [weak self] (status) in
            switch status {
            case .available:
                self?.checkoutButton.set(enabled: true)
            case .notAvailable, .undefined:
                self?.presentAlert(title: "Disponibilidad",
                                   message: "Aplazame no está disponible")
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Checkout"
        navigationItem.applyLogo()
        navigationController?.applyStyle()
        
        AplazameSDK.debugMode = true
    }
    
    fileprivate lazy var order: APZOrder = {
        var order = APZOrder.create(.randomID,
                                 locale: .current,
                                 taxRate: 20,
                                 totalAmount: 2000,
                                 discount: -362)
        order.addRandomArticles()
        return order
    }()
    
    fileprivate func createCheckout() -> APZCheckout {
        var checkout = APZCheckout.create(order)
        checkout.addRandomShippingInfo()
        checkout.addRandomCustomer()
        checkout.addRandomBillingInfo()
        return checkout
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? OrderTableViewController else { return }
        destination.checkout = checkout
    }
}

extension ViewController: APZPaymentContextDelegate {
    func checkoutDidClose(checkoutVC: UIViewController, with reason: APZCheckoutCloseReason) {
        print("checkoutDidCloseWithReason \(reason.rawValue)")
        checkoutVC.dismiss(animated: true, completion: nil)
    }
    
    func checkoutStatusChanged(with status: APZCheckoutStatus) {
        print("checkoutStatusChanged \(status.rawValue)")
    }
}

extension UIButton {
    func set(enabled: Bool) {
        isEnabled = enabled
        alpha = isEnabled ? 1.0 : 0.5
    }
}

extension UIViewController {
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        }))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
