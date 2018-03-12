import UIKit

class ArticleCell: UITableViewCell {
    
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleName: UILabel!
    @IBOutlet weak var articleAmount: UILabel!
    @IBOutlet weak var articleUnitPrice: UILabel!
    
}

extension ArticleCell {
    func configure(with article: [String: Any], locale: Locale) {
        articleImage.load(ImageURL: URL(string: article["image_url"] as! String)!)
        articleName.text = article["name"] as? String
        articleAmount.text = "\(article["quantity"] ?? 1) x"
        articleUnitPrice.text = String.formatted(price: article["price"] as! Int, locale: locale)
    }
}
