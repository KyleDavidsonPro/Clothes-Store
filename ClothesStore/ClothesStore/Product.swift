//
//  Product.swift
//  ClothesStore
//
//  Created by Kyle Davidson on 05/12/2016.
//  Copyright © 2016 Kyle Davidson. All rights reserved.
//

import CoreData
import ObjectMapper

class Product: NSManagedObject, Mappable {
    @NSManaged var id: NSNumber
    @NSManaged var name: String
    @NSManaged var category: String
    @NSManaged var price: NSNumber
    @NSManaged var oldPrice: NSNumber?
    @NSManaged var stock: NSNumber
    
    required init?(map: Map){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let context = appDelegate.managedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Product", in: context) else {
                return nil
        }
        
        
        super.init(entity: entity, insertInto: context)
    }
    
    func mapping(map: Map) {
        id         <- map["productId"]
        name       <- map["name"]
        category   <- map["category"]
        price      <- map["price"]
        oldPrice   <- map["oldPrice"]
        stock      <- map["stock"]
    }
}
