import UIKit
import AplazameSDK

class ArticleCell: UITableViewCell {
    
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleName: UILabel!
    @IBOutlet weak var articleAmount: UILabel!
    @IBOutlet weak var articleUnitPrice: UILabel!
    
}

extension ArticleCell {
    func configure(with article: APZArticle, locale: Locale) {
        articleImage.load(ImageURL: article.imageUrl)
        articleName.text = article.name
        articleAmount.text = "\(article.quantity) x"
        articleUnitPrice.text = String.formatted(price: article.price, locale: locale)
    }
}
