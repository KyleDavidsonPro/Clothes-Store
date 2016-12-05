//
//  Products.swift
//  ClothesStore
//
//  Created by Kyle Davidson on 05/12/2016.
//  Copyright © 2016 Kyle Davidson. All rights reserved.
//

import Foundation

/**
 *  Products Endpoint
 */
enum Products {
    /// Retrieve all products
    case All
    /// Retrieve a specific product
    case Get(String)
}

/// Products Endpoint Implementation
extension Products: Endpoint {
    var url: String {
        return "/products"
    }
    
    var method: String {
        return "GET"
    }
    
    var headers: [String: String]? {
        return nil
    }
}
