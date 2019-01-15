import UIKit
import AplazameSDK

final class ViewController: UIViewController {

    fileprivate var paymentContext: APZPaymentContext?
    
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
    @IBOutlet weak var checkoutIdTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var currencyTextField: UITextField!
    @IBAction func openCheckout(_ sender: AnyObject) {
        guard let checkout_id = checkoutIdTextField.text else { return }
        loadingView.isHidden = false
        paymentContext?.requestCheckout(
            checkout: checkout_id,
            delegate: self,
            onReady: { vc in
                self.loadingView.isHidden = true
                vc.title = "Aplazame"
                self.navigationController?.pushViewController(vc, animated: true)
            }
        )
    }
    
    @IBAction func checkAvailability(_ sender: AnyObject) {
        guard let token = accessTokenTextField.text else { return }
        guard let amount = amountTextField.text else { return }
        guard let currency = currencyTextField.text else { return }
        checkoutButton.set(enabled: false)
        paymentContext = APZPaymentContext(config: APZConfig(accessToken: token, environment: .sandbox))
        paymentContext?.checkAvailability(amount: Int(amount)!,
                                          currency: currency,
                                          callback: { [weak self] (status) in
            switch status {
            case .available:
                self?.checkoutButton.set(enabled: true)
            case .notAvailable:
                self?.presentAlert(title: "Disponibilidad",
                                   message: "Aplazame no está disponible")
            case .undefined:
                self?.presentAlert(title: "Error",
                                   message: "Communication Error")
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
}

extension ViewController: APZPaymentContextDelegate {
    func checkoutDidClose(checkoutVC: UIViewController, with reason: APZCheckoutCloseReason) {
        self.presentAlert(title: "checkoutDidClose",
                           message: reason.rawValue)
        checkoutVC.dismiss(animated: true, completion: nil)
    }
    
    func checkoutStatusChanged(with status: APZCheckoutStatus) {
        self.presentAlert(title: "checkoutStatusChanged",
                          message: status.rawValue)
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
