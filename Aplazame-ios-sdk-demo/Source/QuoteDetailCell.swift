import UIKit

class QuoteDetailCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    
}

extension QuoteDetailCell {
    func configure(with titleText: String, priceInCents: Int, locale: Locale) {
        title.text = titleText
        price.text = .formatted(price: priceInCents, locale: locale)
    }
}
