//
//  ChangeProcessor.swift
//  ClothesStore
//
//  Created by Kyle Davidson on 05/12/2016.
//  Copyright © 2016 Kyle Davidson. All rights reserved.
//

import Foundation

/**
 *  Change Processors used to perform networking tasks that synchronize with core data,
 *  Specific pieces of functionality with very direct and small tasks to perform
 *  e.g. Download all products, download a specific product, delete a specific product etc.
 */
protocol ChangeProcessor {
    func fetchRemoteRecords(forContext context: SyncCoordinatorContext) -> Void
}
