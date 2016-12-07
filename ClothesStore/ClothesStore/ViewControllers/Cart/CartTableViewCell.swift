//
//  CartTableViewCell.swift
//  ClothesStore
//
//  Created by Kyle Davidson on 06/12/2016.
//  Copyright © 2016 Kyle Davidson. All rights reserved.
//

import Foundation
import UIKit

class CartTableViewCell: UITableViewCell {
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var productPriceLabel: UILabel!
}

extension CartTableViewCell: ConfigurableCell {
    func configure(forObject object: Product) {
        productNameLabel.text = object.name
        
        if let reducedPrice = Utils.buildReducedPriceLabel(forProduct: object) {
            productPriceLabel.attributedText = reducedPrice
        } else {
            productPriceLabel.text = "£\(object.price)"
        }
    }
}
