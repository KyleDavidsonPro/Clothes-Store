//
//  Product.swift
//  ClothesStore
//
//  Created by Kyle Davidson on 05/12/2016.
//  Copyright © 2016 Kyle Davidson. All rights reserved.
//

import CoreData
import ObjectMapper

/// Product Managed Object
class Product: NSManagedObject, Mappable {
    @NSManaged var id: NSNumber
    @NSManaged var name: String
    @NSManaged var category: String
    @NSManaged var price: NSNumber
    @NSManaged var oldPrice: NSNumber?
    @NSManaged var stock: NSNumber
    
    /// Relationships
    @NSManaged var cart: Cart?
    @NSManaged var cartId: NSNumber?
    
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    required init?(map: Map){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let context = appDelegate.managedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Product", in: context) else {
                return nil
        }
        
        super.init(entity: entity, insertInto: context)
    }
    
    // MARK: - Mappings
    func mapping(map: Map) {
        id         <- map["productId"]
        name       <- map["name"]
        category   <- map["category"]
        price      <- map["price"]
        oldPrice   <- map["oldPrice"]
        stock      <- map["stock"]
    }
}

// MARK: - Managed Object Type Implementation
extension Product: ManagedObjectType {
    public static var entityName: String {
        return "Product"
    }
    
    public static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: Keys.category.rawValue, ascending: true),
                NSSortDescriptor(key: Keys.name.rawValue, ascending: true)]
    }
}

// MARK: Convenience Extensions
extension Product {
    public enum Keys: String {
        case id = "id"
        case name = "name"
        case category = "category"
        case price = "price"
        case oldPrice = "oldPrice"
        case stock = "stock"
        case cart = "cart"
    }
    
    public static func productsInCart() -> NSFetchRequest<NSManagedObject> {
        let request = NSFetchRequest<NSManagedObject>(entityName: entityName)
        request.sortDescriptors = defaultSortDescriptors
        request.predicate = NSPredicate(format: "%K.%K == 1", Keys.cart.rawValue, Cart.Keys.id.rawValue)
    
        return request
    }
}

