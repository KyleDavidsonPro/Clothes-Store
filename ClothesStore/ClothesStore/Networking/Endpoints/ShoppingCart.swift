//
//  Cart.swift
//  ClothesStore
//
//  Created by Kyle Davidson on 06/12/2016.
//  Copyright © 2016 Kyle Davidson. All rights reserved.
//

import Foundation

/**
 *  Cart Endpoint
 */
enum ShoppingCart {
    /// Retrieve all products
    case add(Product)
    /// Retrieve a specific product
    case remove(String)
}

/// Products Endpoint Implementation
extension ShoppingCart: Endpoint {
    var url: String {
        switch self {
        case .add:
            return "/cart"
        case .remove(let id):
            return "/cart/" + id
        }
    }
    
    var method: String {
        switch self {
        case .add:
            return "POST"
        case .remove:
            return "DELETE"
        }
    }
    
    var body: Data? {
        switch self {
        case .add(let product):
            return NSKeyedArchiver.archivedData(withRootObject: product.toJSON())
        case .remove:
            return nil
        }
    }
}
