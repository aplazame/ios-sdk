//
//  ViewController.swift
//  Aplazame-ios-sdk-demo
//
//  Created by Andres Brun Moreno on 07/05/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import UIKit
import AplazameSDK

final class ViewController: UIViewController {
    
    fileprivate var checkout: Checkout? {
        didSet {
            checkoutButton.set(enabled: checkout != nil)
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
        guard let checkout = checkout else { return }
        AplazameSDK.requestPresent(from: navigationController!,
                                   checkout: checkout,
                                   delegate: self,
                                   onPresent: {
            self.loadingView.isHidden = true
        })
    }
    
    @IBAction func checkAvailability(_ sender: AnyObject) {
        guard let token = accessTokenTextField.text else { return }
        let newCheckout = createCheckout(with: token)
        AplazameSDK.checkAvailability(checkout: newCheckout) { [weak self] (status) in
            switch status {
            case .available:
                self?.checkout = newCheckout
            case .notAvailable, .undefined:
                self?.presentAlert(title: "Disponibilidad",
                                   message: "Aplazame no está disponible")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.applyLogo()
        navigationController?.applyStyle()
        
        AplazameSDK.debugMode = true
    }
    
    fileprivate lazy var order: Order = {
        var order = Order.create(.randomID,
                                 locale: .current,
                                 taxRate: 20,
                                 totalAmount: 2000,
                                 discount: -362)
        order.addRandomArticles()
        return order
    }()
    
    fileprivate func createCheckout(with token: String) -> Checkout {
        let config = Config(accessToken: token, environment: .sandbox)
        var checkout = Checkout.create(order, config: config)
        checkout.addRandomShippingInfo()
        checkout.addRandomCustomer()
        checkout.addRandomBillingInfo()
        return checkout
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? OrderTableViewController else { return }
        destination.checkout = createCheckout(with: "")
    }
}

extension ViewController: AplazameCheckoutDelegate {
    func checkoutStatusChanged(with status: CheckoutStatus) {
        print("checkoutStatusChanged \(status.rawValue)")
    }
    
    func checkoutFinished(with reason: CheckoutCloseReason) {
        print("checkoutDidFinishWithError \(reason.rawValue)")
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
