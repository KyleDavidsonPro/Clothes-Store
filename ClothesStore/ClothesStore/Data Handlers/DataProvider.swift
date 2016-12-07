//
//  DataProvider.swift
//  ClothesStore
//
//  Created by Kyle Davidson on 06/12/2016.
//  Copyright © 2016 Kyle Davidson. All rights reserved.
//

import UIKit

/// Data provider provides information and updates on fetched results to the data source
protocol DataProvider: class {
    associatedtype Object
    func object(at indexPath: IndexPath) -> Object
    func numberOfItems(inSection section: Int) -> Int
}

/// Delegate for the data provider to pass updates to the data source
protocol DataProviderDelegate: class {
    associatedtype Object
    func dataProviderDidUpdate(_ updates: [DataProviderUpdate<Object>]?)
}

/// Updates passed by the data provider to the data source
enum DataProviderUpdate<Object> {
    case insert(IndexPath)
    case update(IndexPath, Object)
    case move(IndexPath, IndexPath)
    case delete(IndexPath)
}
