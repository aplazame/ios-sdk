//
//  PriceExtension.swift
//  Aplazame-ios-sdk-demo
//
//  Created by Andres Brun Moreno on 18/05/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import UIKit

extension String {
    static func formattedPrice(priceInCents: Int, locale: NSLocale) -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = locale
        return formatter.stringFromNumber(CGFloat(priceInCents) * 0.01)!
    }
}