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
        name.text = object.name
        /*category.text = object.category
        price.text = "£\(object.price)"
        stock.text = "Stock: \(object.stock)"*/
    }
}
