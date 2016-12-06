//
//  Endpoint.swift
//  ClothesStore
//
//  Created by Kyle Davidson on 05/12/2016.
//  Copyright © 2016 Kyle Davidson. All rights reserved.
//

import Foundation

/**
 *  A Protocol that describes functionality supported for a HTTP endpoint.
 */
protocol Endpoint {
    /// URL for this endpoint
    var url: String { get }
    /// http Method for this endpoint (E.G. POST)
    var method: String { get }
    /// http headers for this endpoint
    var headers: [String: String]? { get }
}
