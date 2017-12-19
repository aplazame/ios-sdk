//
//  OrderExtension.swift
//  Aplazame-ios-sdk-demo
//
//  Created by Andres Brun Moreno on 10/07/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import AplazameSDK
import Foundation

extension APZOrder {
    mutating func addRandomArticles() {
        addArticle(.create("id1", name: "RELOJ EN ORO BLANCO DE 18 QUILATES Y DIAMANTES", description: "description", url: URL(string: "http://www.chanel.com/es_ES/Relojeria/relojes_joyer%C3%ADa#reloj-en-oro-blanco-de-18-quilates-y-diamantes-J10211")!, imageUrl: URL(string: "https://i.imgur.com/1nIay4X.jpg")!, quantity: 2, price: 3993))
        addArticle(.create("id2", name: "N°5 EAU PREMIERE SPRAY", description: "description", url: URL(string: "http://www.chanel.com/en_US/fragrance-beauty/Fragrance-N%C2%B05-N%C2%B05-88145/sku/138083")!, imageUrl: URL(string: "https://i.imgur.com/CZ5UPbl.jpg")!, price: 3509))
        addArticle(.create("id2", name: "ILLUSION D'OMBRE", description: "description", url: URL(string: "http://www.chanel.com/en_US/fragrance-beauty/Makeup-Eyeshadow-ILLUSION-D%27OMBRE-122567")!, imageUrl: URL(string: "https://i.imgur.com/4j2ib6w.jpg")!, price: 1573))
    }
}
