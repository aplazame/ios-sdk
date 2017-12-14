//
//  APZCheckout.swift
//  Aplazame-sdk
//
//  Created by Andres Brun Moreno on 05/05/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import Foundation

public struct APZCheckout {
    public let order: APZOrder
    let merchant: APZMerchant
    let meta = Meta()
    public var customer: APZCustomer? = nil
    public var billingInfo: BillingInfo? = nil
    public var shippingInfo: APZShippingInfo? = nil
    public var additionalInfo: [String: String]? = nil
}

extension APZCheckout {
    func record(with config: APZConfig) -> APIRecordType {
        var record = APIRecordType()
        record["order"] = order.record
        record["merchant"] = merchant.record >< config.record
        record["customer"] = customer?.record
        record["billing"] = billingInfo?.record
        record["shipping"] = shippingInfo?.record
        record["additional_info"] = additionalInfo
        record["meta"] = meta.record
        record["toc"] = true
        return record
    }
}

public extension APZCheckout {
    public static func create(_ order: APZOrder) -> APZCheckout {
        return APZCheckout(order: order,
                        merchant: .create(),
                        customer: nil,
                        billingInfo: nil,
                        shippingInfo: nil,
                        additionalInfo: nil)
    }
}
