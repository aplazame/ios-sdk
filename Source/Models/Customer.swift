//
//  APZCustomer.swift
//  Aplazame-sdk
//
//  Created by Andres Brun on 14/05/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import Foundation

public enum CustomerType: String {
    case Guest = "g"
    case New = "n"
    case Existing = "e"
}

public enum CustomerGender: String {
    case Male = "1"
    case Female = "2"
    case NotApplicable = "3"
    case Unknown = "0"
}

public struct APZCustomer {
    /**
     APZCustomer ID.
     */
    let id: String
    /**
     The customer email.
     */
    let email: String
    /**
     APZCustomer type, the choices are g:guest, n:new, e:existing.
     */
    let type: CustomerType
    /**
     APZCustomer gender, the choices are 0: not known, 1: male, 2:female, 3: not applicable.
     */
    let gender: CustomerGender
    /**
     APZCustomer first name.
     */
    let firstName: String?
    /**
     APZCustomer last name.
     */
    let lastName: String?
    /**
     APZCustomer birthday
     */
    let birthday: Date?
    /**
     Locale for customer language preferences (ISO 639-1).
     */
    let locale: Locale?
    /**
     A datetime designating when the customer account was created.
     */
    let dateJoined: Date?
    /**
     A datetime of the customer last login.
     */
    let lastLogin: Date?
    /**
     APZCustomer address.
     */
    let address: CustomerAddress?
}

public extension APZCustomer {
    public static func create(
        _ id: String,
        email: String,
        gender: CustomerGender,
        type: CustomerType,
        firstName: String? = nil,
        lastName: String? = nil,
        birthday: Date? = nil,
        locale: Locale? = nil,
        dateJoined: Date? = nil,
        lastLogin: Date? = nil,
        address: CustomerAddress? = nil) -> APZCustomer
    {
        return APZCustomer(id: id, email: email, type: type, gender: gender, firstName: firstName, lastName: lastName, birthday: birthday, locale: locale, dateJoined: dateJoined, lastLogin: lastLogin, address: address)
    }
}

extension APZCustomer {
    var record: APIRecordType {
        var record = APIRecordType()
        record["birthday"] = birthday?.ISO8601GMTString
        record["date_joined"] = dateJoined?.ISO8601GMTString
        record["last_login"] = lastLogin?.ISO8601GMTString
        record["id"] = id
        record["language"] = locale?.languageCode
        record["email"] = email
        record["type"] = type.rawValue
        record["gender"] = gender.rawValue
        record["first_name"] = firstName
        record["last_name"] = lastName
        return record
    }
}
