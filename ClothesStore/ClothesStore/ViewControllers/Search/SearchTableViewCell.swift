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
        if object.stock == 0 {
            disableCell()
        } else {
            enableCell()
        }
        
        productNameLabel.text = object.name
        productCategoryLabel.text = object.category
        productStockLabel.text = "\(object.stock) Available"
        
        if let reducedPrice = Utils.buildReducedPriceLabel(forProduct: object) {
            productPriceLabel.attributedText = reducedPrice
        } else {
            productPriceLabel.text = "£\(object.price)"
        }
    }
    
    /// Disable Cell when stock is not available
    private func disableCell() -> Void {
        self.isUserInteractionEnabled = false
        self.accessoryType = .none
        self.productNameLabel.textColor = Utils.ClothesStoreGrayColor
        self.productPriceLabel.textColor = Utils.ClothesStoreGrayColor
        self.productStockLabel.textColor = UIColor.red
    }
    
    private func enableCell() -> Void {
        self.isUserInteractionEnabled = true
        self.accessoryType = .disclosureIndicator
        self.productNameLabel.textColor = UIColor.black
        self.productPriceLabel.textColor = UIColor.black
        self.productStockLabel.textColor = Utils.ClothesStoreGrayColor
    }
}
