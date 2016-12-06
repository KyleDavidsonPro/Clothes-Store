//
//  ProductDetailViewController.swift
//  ClothesStore
//
//  Created by Kyle Davidson on 06/12/2016.
//  Copyright © 2016 Kyle Davidson. All rights reserved.
//

import Foundation
import UIKit

class ProductDetailViewController: UIViewController, SyncCoordinatorSettable {
    var product: Product!
    weak var syncCoordinator: SyncCoordinator!
    
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var productPriceLabel: UILabel!
    @IBOutlet var productCategoryLabel: UILabel!
    @IBOutlet var addToCartButton: UIButton!
    
    @IBAction func addToCart() {
        syncCoordinator.sync(changeProcessor: CartUploader(product: product))
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productNameLabel.text = product.name
        productPriceLabel.text = "£\(product.price)"
        productCategoryLabel.text = product.category
    }
}
