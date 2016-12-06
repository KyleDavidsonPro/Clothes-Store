//
//  DataProvider.swift
//  ClothesStore
//
//  Created by Kyle Davidson on 06/12/2016.
//  Copyright © 2016 Kyle Davidson. All rights reserved.
//

import UIKit

protocol DataProvider: class {
    associatedtype Object
    func object(at indexPath: IndexPath) -> Object
    func numberOfItems(inSection section: Int) -> Int
}

protocol DataProviderDelegate: class {
    associatedtype Object
    func dataProviderDidUpdate(_ updates: [DataProviderUpdate<Object>]?)
}

enum DataProviderUpdate<Object> {
    case insert(IndexPath)
    case update(IndexPath, Object)
    case move(IndexPath, IndexPath)
    case delete(IndexPath)
}
