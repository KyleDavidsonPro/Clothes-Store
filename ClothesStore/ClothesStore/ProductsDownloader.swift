//
//  ProductsDownloader.swift
//  ClothesStore
//
//  Created by Kyle Davidson on 05/12/2016.
//  Copyright © 2016 Kyle Davidson. All rights reserved.
//

import CoreData
import SwiftyJSON
import ObjectMapper

/// ChangeProcessor for downloading specific downloader with ID
class ProductsDownloader: ChangeProcessor {
    func fetchRemoteRecords(forContext context: SyncCoordinatorContext) {
        context.remote.request(endpoint: Products.all) { (jsonData) in
            guard let productsJson = jsonData.array else {
                return
            }
            
            for productJson in productsJson {
                guard let productDict = productJson.dictionaryObject else {
                    continue
                }
                
                let product = Mapper<Product>().map(JSON: productDict)
            }
        }
    }
}
