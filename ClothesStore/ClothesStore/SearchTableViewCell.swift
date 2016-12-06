//
//  SearchTableViewCell.swift
//  ClothesStore
//
//  Created by Kyle Davidson on 06/12/2016.
//  Copyright © 2016 Kyle Davidson. All rights reserved.
//

import Foundation
import UIKit

class SearchTableViewCell: UITableViewCell {
    @IBOutlet var name: UILabel!
    @IBOutlet var category: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var stock: UILabel!
}

extension SearchTableViewCell: ConfigurableCell {
    func configure(forObject object: Product) {
        let stockInfo = "(\(object.stock) Available)"
        let nameAttStr = NSMutableAttributedString(string: "\(object.name) \(stockInfo)")
        nameAttStr.addAttribute(NSFontAttributeName,
                                value: UIFont.systemFont(ofSize: 13.0),
                                range: NSMakeRange(object.name.characters.count, stockInfo.characters.count + 1))
        
        name.attributedText = nameAttStr
        category.text = object.category
        price.text = "£\(object.price)"
        
        if let oldPriceVal = object.oldPrice {
            let oldPrice = "£\(oldPriceVal)"
            let priceAttStr = NSMutableAttributedString(string: "\(oldPrice) £\(object.price)")
            priceAttStr.addAttribute(NSStrikethroughStyleAttributeName,
                                     value: 2,
                                     range: NSMakeRange(0, oldPrice.characters.count))
            
            price.attributedText = priceAttStr
        }
    }
}
