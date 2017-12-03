//
//  NSDateExtension.swift
//  Aplazame-sdk
//
//  Created by Andres Brun on 14/05/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import Foundation

extension Date {
    var ISO8601GMTString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
}
