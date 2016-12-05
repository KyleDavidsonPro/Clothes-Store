//
//  SearchViewController.swift
//  ClothesStore
//
//  Created by Kyle Davidson on 05/12/2016.
//  Copyright © 2016 Kyle Davidson. All rights reserved.
//

import UIKit
import CoreData
import ObjectMapper

class SearchViewController: UIViewController, ManagedObjectContextSettable, SyncCoordinatorSettable {
    var managedObjectContext: NSManagedObjectContext!
    var syncCoordinator: SyncCoordinator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

