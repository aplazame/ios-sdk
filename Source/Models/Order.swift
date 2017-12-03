//
//  Order.swift
//  Aplazame-sdk
//
//  Created by Andres Brun Moreno on 05/05/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import Foundation

public struct Order {
    /**
     Your order ID.
     */
    let id: String
    /**
     Articles in cart.
     */
    public var articles: [Article]
    /**
     The discount amount of the order.
     */
    public let discount: Decimal?
    /**
     The rate discount of the order.
     */
    public let discountRate: Decimal?
    /**
     The discount amount of the cart.
     */
    public let cartDiscount: Decimal?
    /**
     The rate discount of the cart.
     */
    public let cartDiscountRate: Decimal?
    /**
     Locale for currency code of the order (ISO-4217).
     */
    public let locale: Locale
    /**
     Order tax rate.
     */
    public let taxRate: Decimal
    /**
     Order total amount.
     */
    public let totalAmount: Decimal
}

public extension Order {
    mutating func addArticle(_ article: Article) {
        articles.append(article)
    }
}

public extension Order {
    static func create(
        _ id: String,
        locale: Locale,
        taxRate: Int,
        totalAmount: Int,
        discount: Int? = nil,
        discountRate: Int? = nil,
        cartDiscount: Int? = nil,
        cartDiscountRate: Int? = nil) -> Order
    {
        return Order(id: id, articles: [], discount: discount, discountRate: discountRate, cartDiscount: cartDiscount, cartDiscountRate: cartDiscountRate, locale: locale, taxRate: taxRate, totalAmount: totalAmount)
    }
}

extension Order {
    var record: APIRecordType {
        var record = APIRecordType()
        record["id"] = id
        record["discount"] = discount
        record["discount_rate"] = discountRate
        record["cart_discount"] = cartDiscount
        record["cart_discount_rate"] = cartDiscountRate
        record["currency"] = locale.currencyCode
        record["tax_rate"] = taxRate
        record["total_amount"] = totalAmount
        record["articles"] = articles.map { $0.record }
        return record
    }
}
