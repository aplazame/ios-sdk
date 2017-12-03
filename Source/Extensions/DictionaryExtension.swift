//
//  DictionaryExtension.swift
//  Aplazame-sdk
//
//  Created by Andres Brun on 14/05/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import Foundation

infix operator ><: AdditionPrecedence
func >< <T, V> (lhs: [T: V], rhs: [T: V]?) -> [T: V] {
    var mergedDictionary = [T: V]()
    mergedDictionary+=lhs
    if let rhs = rhs {
        mergedDictionary+=rhs
    }
    return mergedDictionary
}


infix operator +=: AdditionPrecedence
func += <T, V> (lhs: inout [T: V], rhs: [T: V]) {
    for (k, v) in rhs {
        lhs.updateValue(v, forKey: k)
    }
}
