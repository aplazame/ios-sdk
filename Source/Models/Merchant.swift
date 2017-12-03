//
//  Merchant.swift
//  Aplazame-sdk
//
//  Created by Andres Brun on 14/05/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import Foundation

struct Merchant {
    /**
     url that the JS client sent to confirming the order.
     */
    let confirmationUrl: String
    /**
     url that the customer is sent to if there is an error in the checkout.
     */
    let cancelUrl: String
    /**
     url that the customer is sent to after confirming their order.
     */
    let successUrl: String
    /**
     url that the customer is sent to if the customer chooses to back to the eccommerce, by default is /.
     */
    let checkoutUrl: String
    /**
     config object to define environment information
    */
    let config: Config
}

extension Merchant {
    static func create(_ config: Config) -> Merchant {
        return Merchant(confirmationUrl: "/confirmation.html", cancelUrl: "/cancel.html", successUrl: "/success.html", checkoutUrl: "/checkout.html", config: config)
    }
}

extension Merchant {
    var record: APIRecordType {
        var record = APIRecordType()
        record["confirmation_url"] = confirmationUrl
        record["cancel_url"] = cancelUrl
        record["success_url"] = successUrl
        record["checkout_url"] = checkoutUrl
        return record >< config.record
    }
}
