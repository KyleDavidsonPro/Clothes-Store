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
    case all
    /// Retrieve a specific product
    case get(String)
}

/// Products Endpoint Implementation
extension Products: Endpoint {
    var url: String {
        switch self {
        case .all:
            return "/products"
        case .get(let id):
            return "/products/" + id
        }
    }
    
    var method: String {
        return "GET"
    }
    
    var headers: [String: String]? {
        return nil
    }
}
