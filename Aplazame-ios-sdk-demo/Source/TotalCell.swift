//
//  TotalCell.swift
//  Aplazame-ios-sdk-demo
//
//  Created by Andres Brun Moreno on 18/05/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import UIKit

class TotalCell: UITableViewCell {
    
    @IBOutlet weak var amountLabel: UILabel!
    
}

extension TotalCell {
    func configure(with priceInCents: Int, locale: Locale) {
        amountLabel.text = .formatted(price: priceInCents, locale: locale)
    }
}

