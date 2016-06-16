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
    var checkout: Checkout! {
        didSet {
            cellsData = checkout.createCellsData()
        }
    }
    
    private var cellsData: [CellDataType]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
    }
}

extension OrderTableViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return cellsData.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsData[section].numOfItems
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let locale = checkout.order.locale
        
        switch cellsData[indexPath.section] {
        case .ArticleType(let articles):
            let cell = tableView.dequeueReusableCellWithIdentifier("ArticleCell") as! ArticleCell
            cell.configure(articles[indexPath.row], locale: locale)
            return cell
        case .ShippingType(let shippingInfo):
            let cell = tableView.dequeueReusableCellWithIdentifier("QuoteDetailCell") as! QuoteDetailCell
            cell.configure("Shipping", priceInCents: shippingInfo.price, locale: locale)
            return cell
        case .DiscountType(let discount):
            let cell = tableView.dequeueReusableCellWithIdentifier("QuoteDetailCell") as! QuoteDetailCell
            cell.configure("Discount", priceInCents: discount, locale: locale)
            return cell
        case .TotalType(let total):
            let cell = tableView.dequeueReusableCellWithIdentifier("TotalCell") as! TotalCell
            cell.configure(total, locale: locale)
            return cell
        }
    }
}

enum CellDataType {
    case ArticleType([Article])
    case ShippingType(ShippingInfo)
    case DiscountType(Decimal)
    case TotalType(Decimal)
    
    var numOfItems: Int {
        switch self {
        case .ArticleType(let articles): return articles.count
        default: return 1
        }
    }
}

private extension Checkout {
    func createCellsData() -> [CellDataType] {
        var cellsData = [CellDataType]()
        
        cellsData.append(.ArticleType(order.articles))
        if let discount = order.discount {
            cellsData.append(.DiscountType(discount))
        }
        
        if let shippingInfo = shippingInfo {
            cellsData.append(.ShippingType(shippingInfo))
        }
        
        cellsData.append(.TotalType(order.totalAmount))
        
        return cellsData
    }
}
