//
//  UnitTestHelper.swift
//  Aplazame-sdk
//
//  Created by Andres Brun Moreno on 05/06/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import Foundation
@testable import AplazameSDK

extension APZOrder {
    static func createRandomOrder() -> APZOrder {
        return .create("id", locale: .current, taxRate: 20, totalAmount: 100)
    }
}

extension APZAddress {
    static func createRandomAddress() -> APZAddress {
        return .create("fist_name", lastName: "last_name", street: "Street", city: "City", state: "State", locale: .current, postcode: "postCode")
    }
}

extension APZCheckout {
    static func createRandomCheckout() -> APZCheckout {
        var order = APZOrder.create("id", locale: .current, taxRate: 20, totalAmount: 100)
        let fakeURL = URL(string: "http://www.google.com")!
        order.addArticle(.create("id1", name: "article 1", description: "description", url: fakeURL, imageUrl: fakeURL, price: 1000))
        order.addArticle(.create("id2", name: "article 2", description: "description", url: fakeURL, imageUrl: fakeURL, price: 2000))
        return .create(order, config: APZConfig(accessToken: "test", environment: .sandbox))
    }
}

extension APZConfig {
    static func createBasicConfig() -> APZConfig {
        return APZConfig(accessToken: "token", environment: .sandbox)
    }
}
