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
    
    @IBOutlet weak var checkoutButton: UIButton! {
        didSet {
            checkoutButton.moveIconToRight()
        }
    }
    @IBOutlet weak var accessTokenTextField: UITextField!
    @IBAction func openCheckout(_ sender: AnyObject) {
        if let text = accessTokenTextField.text , !text.isEmpty {
            AplazameSDK.present(from: navigationController!, checkout: createCheckout(with: text), delegate: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.applyLogo()
        navigationController?.applyStyle()
        
        AplazameSDK.debugMode = true
    }
    
    fileprivate lazy var order: Order = {
        var order = Order.create(.randomID, locale: .current, taxRate: 20, totalAmount: 2000, discount: -362)
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
    public func checkoutHandle(checkoutToken token: String, handler: (Bool) -> Void) {
        print("checkoutHandleCheckoutToken \(token)")
        handler(true)
    }

    func checkoutDidCancel() {
         print("checkoutDidCancel")
    }
    
    func checkoutDidSuccess() {
         print("checkoutDidSuccess")
    }

    func checkoutFinished(with error: Error) {
        print("checkoutDidFinishWithError \(error.localizedDescription)")
    }
}
