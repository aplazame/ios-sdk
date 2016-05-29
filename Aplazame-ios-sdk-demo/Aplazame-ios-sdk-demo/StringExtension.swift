//
//  StringExtension.swift
//  Aplazame-ios-sdk-demo
//
//  Created by Andres Brun on 29/05/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import Foundation

extension String {
    static var randomID: String {
        
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".characters
        let lettersLength = UInt32(letters.count)
        
        let randomCharacters = (0..<4).map { i -> String in
            let offset = Int(arc4random_uniform(lettersLength))
            let c = letters[letters.startIndex.advancedBy(offset)]
            return String(c)
        }
        
        return randomCharacters.joinWithSeparator("")
    }
}