//
//  QuoteDetailCell.swift
//  Aplazame-ios-sdk-demo
//
//  Created by Andres Brun Moreno on 18/05/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import UIKit

class QuoteDetailCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    
}

extension QuoteDetailCell {
    func configure(title: String, priceInCents: Int, locale: NSLocale) {
        
    }
}