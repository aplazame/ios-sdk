//
//  PriceExtension.swift
//  Aplazame-ios-sdk-demo
//
//  Created by Andres Brun Moreno on 18/05/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import UIKit

extension String {
    static func formattedPrice(_ priceInCents: Int, locale: Locale) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = locale
        let amount = Double(priceInCents) * Double(0.01)
        return formatter.string(from: NSNumber(value: amount))!
    }
}
