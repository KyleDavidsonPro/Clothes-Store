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

/// ChangeProcessor for downloading specific downloader with ID
class ProductDownloader: ChangeProcessor {
    var id: String
    
    init(id: String) {
        self.id = id
    }
    
    func fetchRemoteRecords(forContext context: SyncCoordinatorContext) {
        context.remote.request(endpoint: Products.get(id)) { (jsonData) in
            guard let productJson = jsonData.dictionaryObject else {
                return
            }
            
            let product = Mapper<Product>().map(JSON: productJson)
        }
    }
}
