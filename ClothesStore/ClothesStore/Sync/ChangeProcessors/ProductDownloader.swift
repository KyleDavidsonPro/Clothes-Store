//
//  ProductDownloader.swift
//  ClothesStore
//
//  Created by Kyle Davidson on 05/12/2016.
//  Copyright © 2016 Kyle Davidson. All rights reserved.
//

import CoreData
import SwiftyJSON
import ObjectMapper

/// ChangeProcessor for downloading specific product with ID
class ProductDownloader: ChangeProcessor {
    var id: String
    
    init(id: String) {
        self.id = id
    }
    
    func fetchRemoteRecords(forContext context: SyncCoordinatorContext) {
        context.remote.request(endpoint: Products.get(id)) { (jsonData) in
            guard let productDict = jsonData.dictionaryObject,
                let id = productDict["productId"] as? NSNumber else {
                return
            }
            
            // Check to see if we already have the remote object locally
            let predicate = NSPredicate(format: "%K == %@", Product.Keys.id.rawValue, id)
            
            //If it already exists just update data, if not create new
            if let existingProduct = Product.findOrFetchInContext(context.moc, matchingPredicate: predicate) {
                let map = Map(mappingType: .fromJSON, JSON: productDict)
                existingProduct.mapping(map: map)
            } else {
                let _ = Mapper<Product>().map(JSON: productDict)
            }
            
            context.moc.trySave()
        }
    }
}
