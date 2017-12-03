//
//  ShippingInfo.swift
//  Aplazame-sdk
//
//  Created by Andres Brun on 14/05/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import Foundation

public struct ShippingInfo {
    /**
     Shipping name.
     */
    public let name: String
    /**
     Shipping price (tax is not included).
     */
    public let price: Decimal
    /**
     Shipping tax rate.
     */
    public let taxRate: Decimal?
    /**
     The discount amount of the shipping.
     */
    public let discount: Decimal?
    /**
     The rate discount of the shipping.
     */
    public let discountRate: Decimal?
    /**
     Shipping Address
     */
    public let address: Address
}

public extension ShippingInfo {
    public static func create(
        _ name: String,
        price: Int,
        address: Address,
        taxRate: Int? = nil,
        discount: Int? = nil,
        discountRate: Int? = nil) -> ShippingInfo
    {
        return ShippingInfo(name: name, price: price, taxRate: taxRate, discount: discount, discountRate: discountRate, address: address)
    }
}

extension ShippingInfo {
    var record: APIRecordType {
        var record = APIRecordType()
        record["name"] = name
        record["price"] = price
        record["taxR_rate"] = taxRate
        record["discount"] = discount
        record["discount_rate"] = discountRate
        return record >< address.record
    }
}
