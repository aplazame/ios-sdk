//
//  CustomerAddress.swift
//  Aplazame-sdk
//
//  Created by Andres Brun on 14/05/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import Foundation

public typealias CustomerAddress = Address
public typealias BillingInfo = Address

public struct Address {
    /**
     Address first name.
     */
    let firstName: String
    /**
     Address last name.
     */
    let lastName: String
    /**
     Address phone number.
     */
    let phone: String?
    /**
     Address alternative phone.
     */
    let altPhone: String?
    /**
     Address street.
     */
    let street: String
    /**
     Address address addition.
     */
    let addressAddition: String?
    /**
     Address city.
     */
    let city: String
    /**
     Address state.
     */
    let state: String
    /**
     Locale for address country code (ISO 3166-1).
     */
    let locale: Locale
    /**
     Address postcode.
     */
    let postcode: String
}

public extension Address {
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
        addressAddition: String? = nil) -> Address
    {
        return Address(firstName: firstName, lastName: lastName, phone: phone, altPhone: altPhone, street: street, addressAddition: addressAddition, city: city, state: state, locale: locale, postcode: postcode)
    }
}

extension Address {
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
