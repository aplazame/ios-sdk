import Foundation

public struct APZCheckout {
    public let order: APZOrder
    public let merchant: APZMerchant
    public let meta: Meta = Meta()
    public var customer: APZCustomer? = nil
    public var billingInfo: BillingInfo? = nil
    public var shippingInfo: APZShippingInfo? = nil
    public var additionalInfo: [String: String]? = nil
}

extension APZCheckout {
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
