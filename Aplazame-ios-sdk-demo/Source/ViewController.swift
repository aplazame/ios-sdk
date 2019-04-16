import UIKit
import AplazameSDK

final class ViewController: UIViewController {

    fileprivate var paymentContext: APZPaymentContext?
    
    @IBOutlet weak var bottomButtonConstraint: NSLayoutConstraint!
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
        paymentContext?.checkAvailability(amount: Double(amount)!,
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
        
        NotificationCenter.default
            .addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default
            .addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadingView.isHidden = true
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        bottomButtonConstraint.constant = keyboardSize.height + 8
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        bottomButtonConstraint.constant = 8
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

extension ViewController: APZPaymentContextDelegate {
    func checkoutDidClose(checkoutVC: UIViewController, with reason: APZCheckoutCloseReason) {
        navigationController?.popViewController(animated: true)
        presentAlert(title: "checkoutDidClose",
                     message: reason.rawValue)
    }
    
    func checkoutStatusChanged(with status: APZCheckoutStatus) {
        presentAlert(title: "checkoutStatusChanged",
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
