import UIKit

class TotalCell: UITableViewCell {
    
    @IBOutlet weak var amountLabel: UILabel!
    
}

extension TotalCell {
    func configure(with priceInCents: Int, locale: Locale) {
        amountLabel.text = .formatted(price: priceInCents, locale: locale)
    }
}

