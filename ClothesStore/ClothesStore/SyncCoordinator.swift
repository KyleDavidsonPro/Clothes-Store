//
//  SyncCoordinator.swift
//  ClothesStore
//
//  Created by Kyle Davidson on 05/12/2016.
//  Copyright © 2016 Kyle Davidson. All rights reserved.
//

import CoreData

/* ChangeProcessors should only have access to the parts of a sync coordinator that it needs
 * Important as class grows
 **/
protocol SyncCoordinatorContext {
    var moc: NSManagedObjectContext { get }
    var remote: APIManager { get }
}

/* SyncCoordinator handles synchronization between networking and core data layers via change-processors
 *
 **/
class SyncCoordinator: ManagedObjectContextSettable {
    var managedObjectContext: NSManagedObjectContext!
    var remote: APIManager
    
    init(managedObjectContext: NSManagedObjectContext, remote: APIManager) {
        self.managedObjectContext = managedObjectContext
        self.remote = remote
    }
    
    func sync(changeProcessor: ChangeProcessor) {
        changeProcessor.fetchRemoteRecords(forContext: self)
    }
}

extension SyncCoordinator: SyncCoordinatorContext {
    var moc: NSManagedObjectContext {
        return managedObjectContext
    }
}
