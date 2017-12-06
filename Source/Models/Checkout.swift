//
//  Checkout.swift
//  Aplazame-sdk
//
//  Created by Andres Brun Moreno on 05/05/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import Foundation

public struct Checkout {
    public let order: Order
    let merchant: Merchant
    let meta = Meta()
    public var customer: Customer? = nil
    public var billingInfo: BillingInfo? = nil
    public var shippingInfo: ShippingInfo? = nil
    public var additionalInfo: [String: String]? = nil
}

extension Checkout {
    var record: APIRecordType {
        var record = APIRecordType()
        record["order"] = order.record
        record["merchant"] = merchant.record
        record["customer"] = customer?.record
        record["billing"] = billingInfo?.record
        record["shipping"] = shippingInfo?.record
        record["additional_info"] = additionalInfo
        record["meta"] = meta.record
        record["toc"] = true
        return record
    }
}

public extension Checkout {
    public static func create(_ order: Order, config: Config) -> Checkout {
        return Checkout(order: order, merchant: .create(config), customer: nil, billingInfo: nil, shippingInfo: nil, additionalInfo: nil)
    }
}
