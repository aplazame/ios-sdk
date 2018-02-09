import Foundation

public typealias CustomerAddress = APZAddress
public typealias BillingInfo = APZAddress

public struct APZAddress {
    /**
     APZAddress first name.
     */
    let firstName: String
    /**
     APZAddress last name.
     */
    let lastName: String
    /**
     APZAddress phone number.
     */
    let phone: String?
    /**
     APZAddress alternative phone.
     */
    let altPhone: String?
    /**
     APZAddress street.
     */
    let street: String
    /**
     APZAddress address addition.
     */
    let addressAddition: String?
    /**
     APZAddress city.
     */
    let city: String
    /**
     APZAddress state.
     */
    let state: String
    /**
     Locale for address country code (ISO 3166-1).
     */
    let locale: Locale
    /**
     APZAddress postcode.
     */
    let postcode: String
}

public extension APZAddress {
    public static func create(
        _ firstName: String,
        lastName: String,
        street: String,
        city: String,
        state: String,
        locale: Locale,
        postcode: String,
        phone: String? = nil,
        altPhone: String? = nil,
        addressAddition: String? = nil) -> APZAddress
    {
        return APZAddress(firstName: firstName, lastName: lastName, phone: phone, altPhone: altPhone, street: street, addressAddition: addressAddition, city: city, state: state, locale: locale, postcode: postcode)
    }
}

extension APZAddress {
    var record: APIRecordType {
        var record = APIRecordType()
        record["first_name"] = firstName as AnyObject?
        record["last_name"] = lastName as AnyObject?
        record["phone"] = phone as AnyObject?
        record["alt_phone"] = altPhone as AnyObject?
        record["street"] = street as AnyObject?
        record["address_addition"] = addressAddition as AnyObject?
        record["city"] = city as AnyObject?
        record["state"] = state as AnyObject?
        record["country"] = (locale as NSLocale).object(forKey: NSLocale.Key.countryCode) as? String as AnyObject?
        record["postcode"] = postcode as AnyObject?
        return record
    }
}
