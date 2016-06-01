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
        presentViewController(createAplazameCheckoutVC(), animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.applyLogo()
        navigationController?.applyStyle()        
    }
    
    private lazy var order: Order = {
        var order = Order.create(.randomID, currency: .currentLocale(), taxRate: 20, totalAmount: 2000, discount: -362)
        order.addRandomArticles()
        return order
    }()
    
    private lazy var checkout: Checkout = {
        var checkout = Checkout.create(self.order)
        checkout.addRandomShippingInfo()
        checkout.addRandomCustomer()
        checkout.addRandomBillingInfo()
        return checkout
    }()
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? OrderTableViewController {
            destination.checkout = checkout
        }
    }

    private func createAplazameCheckoutVC() -> AplazameCheckoutViewController {
        let config = Config(accessToken: accessTokenTextField.text ?? "", environment: .Sandbox)
        let checkoutData = CheckoutControllerData(checkout: checkout, config: config)
        
        return AplazameCheckoutViewController.create(checkoutData, delegate: self)
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

extension Order {
    mutating func addRandomArticles() {
        addArticle(.create("id1", name: "RELOJ EN ORO BLANCO DE 18 QUILATES Y DIAMANTES", description: "description", url: NSURL(string: "http://www.chanel.com/es_ES/Relojeria/relojes_joyer%C3%ADa#reloj-en-oro-blanco-de-18-quilates-y-diamantes-J10211")!, imageUrl: NSURL(string: "https://i.imgur.com/1nIay4X.jpg")!, quantity: 2, price: 3993))
        addArticle(.create("id2", name: "N°5 EAU PREMIERE SPRAY", description: "description", url: NSURL(string: "http://www.chanel.com/en_US/fragrance-beauty/Fragrance-N%C2%B05-N%C2%B05-88145/sku/138083")!, imageUrl: NSURL(string: "https://i.imgur.com/CZ5UPbl.jpg")!, price: 3509))
        addArticle(.create("id2", name: "ILLUSION D'OMBRE", description: "description", url: NSURL(string: "http://www.chanel.com/en_US/fragrance-beauty/Makeup-Eyeshadow-ILLUSION-D%27OMBRE-122567")!, imageUrl: NSURL(string: "https://i.imgur.com/4j2ib6w.jpg")!, price: 1573))
    }
}

extension Checkout {
    mutating func addRandomShippingInfo() {
        let address = Address.create("Fernando", lastName: "Cabello", street: "Torre Picasso, Plaza Pablo Ruiz Picasso 1", city: "Madrid", state: "Madrid", country: .currentLocale(), postcode: "28020")
        shippingInfo = .create("Fernando", price: 500, address: address)
    }
    
    mutating func addRandomCustomer() {
        customer = .create("140", email: "dev@aplazame.com", gender: .Male, type: .Existing)
    }
    
    mutating func addRandomBillingInfo() {
        billingInfo = BillingInfo.create("Frank", lastName: "Costello", street: "Torre Picasso, Plaza Pablo Ruiz Picasso 1", city: "Madrid", state: "Madrid", country: .currentLocale(), postcode: "28020")
    }
}