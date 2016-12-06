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
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var productCategoryLabel: UILabel!
    @IBOutlet var productPriceLabel: UILabel!
    @IBOutlet var productStockLabel: UILabel!
}

extension SearchTableViewCell: ConfigurableCell {
    func configure(forObject object: Product) {
        productNameLabel.text = object.name
        productCategoryLabel.text = object.category
        productStockLabel.text = "\(object.stock) Available"
        
        if let reducedPrice = Utils.buildReducedPriceLabel(forProduct: object) {
            productPriceLabel.attributedText = reducedPrice
        } else {
            productPriceLabel.text = "£\(object.price)"
        }
    }
}
