//
//  ManagedObjectContextSettable.swift
//  ClothesStore
//
//  Created by Kyle Davidson on 05/12/2016.
//  Copyright © 2016 Kyle Davidson. All rights reserved.
//

import CoreData

protocol ManagedObjectContextSettable {
    var managedObjectContext: NSManagedObjectContext! { get set }
}
