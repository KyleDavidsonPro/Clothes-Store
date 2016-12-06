//
//  CartRemover.swift
//  ClothesStore
//
//  Created by Kyle Davidson on 06/12/2016.
//  Copyright © 2016 Kyle Davidson. All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

/// ChangeProcessor for removing specific product from shopping cart with ID
class CartRemover: ChangeProcessor {
    var product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    func fetchRemoteRecords(forContext context: SyncCoordinatorContext) {
        let cartId = "\(product.cartId)"
        
        context.remote.request(endpoint: ShoppingCart.remove(cartId)) { _ in
            //if successful on remote, remove locally
            self.product.cart = nil
            context.moc.trySave()
        }
    }
}
