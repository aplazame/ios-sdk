import Foundation

typealias APIRecordType = [String: Any]
public typealias Decimal = Int


public struct APZArticle {
    /**
     The article ID.
     */
    let id: String
    /**
     APZArticle name.
     */
    public let name: String
    /**
     APZArticle description.
     */
    public let description: String?
    /**
     APZArticle url.
     */
    public let url: URL
    /**
     APZArticle image url.
     */
    public let imageUrl: URL
    /**
     APZArticle quantity.
     */
    public let quantity: Int
    /**
     APZArticle price (tax is not included).
     */
    public let price: Decimal
    /**
     APZArticle tax_rate.
     */
    public let taxRate: Decimal?
    /**
     The discount amount of the article.
     */
    public let discount: Decimal?
    /**
     The rate discount of the article.
     */
    public let discountRate: Decimal?
}

public extension APZArticle {
    public static func create(
        _ id: String,
        name: String,
        description: String,
        url: URL,
        imageUrl: URL,
        quantity: Int = 1,
        price: Int,
        taxRate: Int = 0,
        discount: Int = 0,
        discountRate: Int = 0) -> APZArticle
    {
        return APZArticle(id: id, name: name, description: description, url: url, imageUrl: imageUrl, quantity: quantity, price: price, taxRate: taxRate, discount: discount, discountRate: discountRate)
    }
}

extension APZArticle {
    var record: APIRecordType {
        var record = APIRecordType()
        record["id"] = id as AnyObject?
        record["name"] = name as AnyObject?
        record["description"] = description as AnyObject?
        record["url"] = url.absoluteString as AnyObject?
        record["image_url"] = imageUrl.absoluteString as AnyObject?
        record["quantity"] = quantity as AnyObject?
        record["price"] = price as AnyObject?
        record["tax_rate"] = taxRate as AnyObject?
        record["discount"] = discount as AnyObject?
        record["discount_rate"] = discountRate as AnyObject?
        return record
    }
}

