//
//  CheckoutTests.swift
//  Aplazame-sdk
//
//  Created by Andres Brun on 15/05/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import XCTest
@testable import AplazameSDK

class CheckoutTests: XCTestCase {
    
    func testOrderCreation_AddArticles() {
        var order = Order.createRandomOrder()
        let fakeURL = URL(string: "http://www.google.com")!
        order.addArticle(.create("id1", name: "article 1", description: "description", url: fakeURL, imageUrl: fakeURL, price: 1000))
        order.addArticle(.create("id2", name: "article 2", description: "description", url: fakeURL, imageUrl: fakeURL, price: 2000))
        
        XCTAssertTrue(order.articles.count == 2, "2 Articles should be in Order")
        XCTAssertNotNil(order.record["articles"])
    }
    
    func testCreateCheckout_WithBillingInfo() {
        var checkout = Checkout.create(.createRandomOrder(), config: .createBasicConfig())
        checkout.billingInfo = .createRandomAddress()
        
        XCTAssertNotNil(checkout.record["billing"])
    }
    
    func testCreateCheckout_WithShippingInfo() {
        var checkout = Checkout.create(.createRandomOrder(), config: .createBasicConfig())
        checkout.shippingInfo = ShippingInfo.create("Name", price: 1000, address: .createRandomAddress())
        
        XCTAssertNotNil(checkout.record["shipping"])
    }
    
    func testCreateCheckout_WithCustomer() {
        var checkout = Checkout.create(.createRandomOrder(), config: .createBasicConfig())
        checkout.customer = .create("id", email: "email@mail.com", gender: .Male, type: .New)
        
        XCTAssertNotNil(checkout.record["customer"])
    }
}

