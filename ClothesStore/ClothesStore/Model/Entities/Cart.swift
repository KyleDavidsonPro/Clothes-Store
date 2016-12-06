//
//  Cart.swift
//  ClothesStore
//
//  Created by Kyle Davidson on 06/12/2016.
//  Copyright © 2016 Kyle Davidson. All rights reserved.
//

import CoreData
import ObjectMapper

class Cart: NSManagedObject {
    @NSManaged var id: String
    @NSManaged var products: Set<Product>?
}

// MARK: - Managed Object Type Implementation
extension Cart: ManagedObjectType {
    public static var entityName: String {
        return "Cart"
    }
}

// MARK: Convenience Extensions
extension Cart {
    public enum Keys: String {
        case id = "id"
    }
}


