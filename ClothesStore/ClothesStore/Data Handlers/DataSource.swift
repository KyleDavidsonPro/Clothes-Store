//
//  DataSource.swift
//  ClothesStore
//
//  Created by Kyle Davidson on 06/12/2016.
//  Copyright © 2016 Kyle Davidson. All rights reserved.
//

import Foundation

protocol DataSourceDelegate: class {
    associatedtype Object
    var editable: Bool { get }
    func cellIdentifierForObject(_ object: Object) -> String
    func removeObject(_ object: Object)
}
