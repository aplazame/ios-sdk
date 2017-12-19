//
//  CheckoutExtension.swift
//  Aplazame-ios-sdk-demo
//
//  Created by Andres Brun Moreno on 10/07/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import AplazameSDK

extension APZCheckout {
    mutating func addRandomShippingInfo() {
        let address = APZAddress.create("Fernando", lastName: "Cabello", street: "Torre Picasso, Plaza Pablo Ruiz Picasso 1", city: "Madrid", state: "Madrid", locale: .current, postcode: "28020")
        shippingInfo = .create("Fernando", price: 500, address: address)
    }
    
    mutating func addRandomCustomer() {
        customer = .create("140", email: "dev@aplazame.com", gender: .male, type: .existing)
    }
    
    mutating func addRandomBillingInfo() {
        billingInfo = BillingInfo.create("Frank", lastName: "Costello", street: "Torre Picasso, Plaza Pablo Ruiz Picasso 1", city: "Madrid", state: "Madrid", locale: .current, postcode: "28020")
    }
}
