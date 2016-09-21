//
//  ViewController.swift
//  Aplazame-ios-sdk-demo
//
//  Created by Andres Brun Moreno on 07/05/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import UIKit
import AplazameSDK

class ViewController: UIViewController {
    
    @IBOutlet weak var checkoutButton: UIButton! {
        didSet {
            checkoutButton.moveIconToRight()
        }
    }
    @IBOutlet weak var accessTokenTextField: UITextField!
    @IBAction func openCheckout(sender: AnyObject) {
        if let text = accessTokenTextField.text where !text.isEmpty {
            AplazameSDK.presentFromVC(navigationController!, checkout: createCheckout(text), delegate: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.applyLogo()
        navigationController?.applyStyle()
        
        AplazameSDK.debugMode = true
    }
    
    private lazy var order: Order = {
        var order = Order.create(.randomID, locale: .currentLocale(), taxRate: 20, totalAmount: 2000, discount: -362)
        order.addRandomArticles()
        return order
    }()
    
    private func createCheckout(token: String) -> Checkout {
        let config = Config(accessToken: token, environment: .Sandbox)
        var checkout = Checkout.create(self.order, config: config)
        checkout.addRandomShippingInfo()
        checkout.addRandomCustomer()
        checkout.addRandomBillingInfo()
        return checkout
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? OrderTableViewController {
            destination.checkout = createCheckout("")
        }
    }
}

extension ViewController: AplazameCheckoutDelegate {
    func checkoutDidCancel() {
         print("checkoutDidCancel")
    }
    
    func checkoutDidSuccess() {
         print("checkoutDidSuccess")
    }
    
    func checkoutHandleCheckoutToken(token: String, handler: (success: Bool) -> Void) {
        print("checkoutHandleCheckoutToken \(token)")
        handler(success: true)
    }
    
    func checkoutDidFinishWithError(error: NSError) {
         print("checkoutDidFinishWithError \(error.description)")
    }
}


