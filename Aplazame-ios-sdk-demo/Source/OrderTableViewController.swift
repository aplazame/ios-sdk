import UIKit
import AplazameSDK

class OrderTableViewController: UITableViewController {
    var checkout: APZCheckout! {
        didSet {
            cellsData = checkout.createCellsData()
        }
    }
    
    fileprivate var cellsData: [CellDataType]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
    }
}

extension OrderTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return cellsData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsData[section].numOfItems
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let locale = checkout.order.locale
        
        switch cellsData[(indexPath as NSIndexPath).section] {
        case .articleType(let articles):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell") as! ArticleCell
            cell.configure(with: articles[(indexPath as NSIndexPath).row], locale: locale)
            return cell
        case .shippingType(let shippingInfo):
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteDetailCell") as! QuoteDetailCell
            cell.configure(with: "Shipping", priceInCents: shippingInfo.price, locale: locale)
            return cell
        case .discountType(let discount):
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteDetailCell") as! QuoteDetailCell
            cell.configure(with: "Discount", priceInCents: discount, locale: locale)
            return cell
        case .totalType(let total):
            let cell = tableView.dequeueReusableCell(withIdentifier: "TotalCell") as! TotalCell
            cell.configure(with: total, locale: locale)
            return cell
        }
    }
}

enum CellDataType {
    case articleType([APZArticle])
    case shippingType(APZShippingInfo)
    case discountType(Int)
    case totalType(Int)
    
    var numOfItems: Int {
        switch self {
        case .articleType(let articles): return articles.count
        default: return 1
        }
    }
}

private extension APZCheckout {
    func createCellsData() -> [CellDataType] {
        var cellsData = [CellDataType]()
        
        cellsData.append(.articleType(order.articles))
        if let discount = order.discount {
            cellsData.append(.discountType(discount))
        }
        
        if let shippingInfo = shippingInfo {
            cellsData.append(.shippingType(shippingInfo))
        }
        
        cellsData.append(.totalType(order.totalAmount))
        
        return cellsData
    }
}
