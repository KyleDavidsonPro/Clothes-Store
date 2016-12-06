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
    
    @IBOutlet var addToCartButton: UIButton!
    
    @IBAction func addToCart() {
        print("test")
    }
}

extension SearchTableViewCell: ConfigurableCell {
    func configure(forObject object: Product) {
        name.text = object.name
        category.text = object.category
        addToCartButton.setTitle("Add To Cart (\(object.stock) Available)", for: .normal)
        
        if let reducedPrice = buildReducedPriceLabel(forProduct: object) {
            price.attributedText = reducedPrice
        } else {
            price.text = "£\(object.price)"
        }
    }
    
    private func buildReducedPriceLabel(forProduct product: Product) -> NSAttributedString? {
        guard let oldPriceVal = product.oldPrice else {
            return nil
        }
        
        let oldPrice = "£\(oldPriceVal)"
        let priceAttStr = NSMutableAttributedString(string: "\(oldPrice) £\(product.price)")
        priceAttStr.addAttribute(NSStrikethroughStyleAttributeName,
                                 value: 2,
                                 range: NSMakeRange(0, oldPrice.characters.count))
        
        return priceAttStr
    }
}
