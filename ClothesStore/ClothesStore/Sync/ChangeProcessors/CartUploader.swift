//
//  CartUploader.swift
//  ClothesStore
//
//  Created by Kyle Davidson on 06/12/2016.
//  Copyright © 2016 Kyle Davidson. All rights reserved.
//

import CoreData
import SwiftyJSON
import ObjectMapper

/// ChangeProcessor for adding product to shopping cart
class CartUploader: ChangeProcessor {
    var product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    func fetchRemoteRecords(forContext context: SyncCoordinatorContext) {
        context.remote.request(endpoint: ShoppingCart.add(product)) { (jsonData) in
            guard let productDict = jsonData.dictionaryObject,
                let _ = productDict["productId"] as? NSNumber,
                let cartId = productDict["cartId"] as? NSNumber else {
                    return
            }
            
            // Connect the product and shopping cart locally
            let cartPredicate = NSPredicate(format: "%K == 1", Cart.Keys.id.rawValue)
            
            // Associate the product to the shopping cart
            if let shoppingCart = Cart.findOrFetchInContext(context.moc, matchingPredicate: cartPredicate) {
                self.product.cart = shoppingCart
                self.product.cartId = cartId
            }
            
            context.moc.trySave()
        }
    }
}
