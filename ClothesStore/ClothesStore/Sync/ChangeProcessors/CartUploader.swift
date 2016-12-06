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

/// ChangeProcessor for downloading specific downloader with ID
class CartUploader: ChangeProcessor {
    var cart: Cart
    
    init(cart: Cart) {
        self.cart = cart
    }
    
    func fetchRemoteRecords(forContext context: SyncCoordinatorContext) {
    }
}
