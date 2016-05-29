//
//  OrderTableViewController.swift
//  Aplazame-ios-sdk-demo
//
//  Created by Andres Brun Moreno on 18/05/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import UIKit
import AplazameSDK

class OrderTableViewController: UITableViewController {
    var order: Order!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
    }
}

extension OrderTableViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return order.calculateVisibleRows
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0..<order.articles.count:
            let cell = tableView.dequeueReusableCellWithIdentifier("ArticleCell")! as! ArticleCell
            cell.configure(order.articles[indexPath.row], locale: order.currency)
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("TotalCell")! as! TotalCell
            cell.configure(order.totalAmount, locale: order.currency)
            return cell
        }
//        if indexPath.row == 1 {
//            return tableView.dequeueReusableCellWithIdentifier("QuoteDetailCell")! as! QuoteDetailCell
//        }
//        
//        if indexPath.row == 2 {
//            return tableView.dequeueReusableCellWithIdentifier("TotalCell")! as! TotalCell
//        }
        
        
    }
    
    
    
}

//enum CellDataType {
//    case ArticleType(Article)
//    case SendType(ShippingInfo)
//    case DiscountType(Decimal)
//}

private extension Order {
    var calculateVisibleRows: Int {
        return articles.count + 1
    }
    
//    func createCellsData() -> [CellDataType] {
//        let articlesData = articles.map { CellDataType.ArticleType($0) }
//        let sendData =
//        
//        return articlesData + [.SendType(shippin)] +
//    }
}
