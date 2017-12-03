//
//  UnitTestHelper.swift
//  Aplazame-sdk
//
//  Created by Andres Brun Moreno on 05/06/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import Foundation
@testable import AplazameSDK

extension Order {
    static func createRandomOrder() -> Order {
        return .create("id", locale: .current, taxRate: 20, totalAmount: 100)
    }
}

extension Address {
    static func createRandomAddress() -> Address {
        return .create("fist_name", lastName: "last_name", street: "Street", city: "City", state: "State", locale: .current, postcode: "postCode")
    }
}

extension Checkout {
    static func createRandomCheckout() -> Checkout {
        var order = Order.create("id", locale: .current, taxRate: 20, totalAmount: 100)
        let fakeURL = URL(string: "http://www.google.com")!
        order.addArticle(.create("id1", name: "article 1", description: "description", url: fakeURL, imageUrl: fakeURL, price: 1000))
        order.addArticle(.create("id2", name: "article 2", description: "description", url: fakeURL, imageUrl: fakeURL, price: 2000))
        return .create(order, config: Config(accessToken: "test", environment: .sandbox))
    }
}

extension Config {
    static func createBasicConfig() -> Config {
        return Config(accessToken: "token", environment: .sandbox)
    }
}
