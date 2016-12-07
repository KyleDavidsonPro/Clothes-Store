//
//  ClothesStoreTests.swift
//  ClothesStoreTests
//
//  Created by Kyle Davidson on 05/12/2016.
//  Copyright © 2016 Kyle Davidson. All rights reserved.
//

import XCTest
import CoreData
@testable import ClothesStore

class DependancyInjectionTests: XCTestCase {
    var tabBarViewControllers: [UIViewController]!
    
    override func setUp() {
        super.setUp()
        
        let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let tabBarController = sb.instantiateInitialViewController() as? UITabBarController,
            let tabBarViewControllers = tabBarController.viewControllers else {
            XCTFail("Could not find the tab bar controller")
            return
        }
        
        self.tabBarViewControllers = tabBarViewControllers
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testManagedObjectContextSettableInjection() {
        for viewController in tabBarViewControllers {
            if var mocSettable = (viewController as? UINavigationController)?.topViewController as? ManagedObjectContextSettable {
                mocSettable.managedObjectContext = NSManagedObjectContext()
            }
        }
        
        guard let searchVC = (tabBarViewControllers.first as? UINavigationController)?.topViewController as? SearchViewController,
            let cartVC = (tabBarViewControllers.last as? UINavigationController)?.topViewController as? CartViewController else {
            XCTFail("Unexpected view controller for first tab")
            return
        }
        
        XCTAssertNotNil(searchVC.managedObjectContext)
        XCTAssertNotNil(cartVC.managedObjectContext)
    }
    
    func testSyncCoordinatorSettableInjection() {
        let mockCoordinator = SyncCoordinator(managedObjectContext: NSManagedObjectContext(), remote: APIManager())
        
        for viewController in tabBarViewControllers {
            if var syncSettable = (viewController as? UINavigationController)?.topViewController as? SyncCoordinatorSettable {
                syncSettable.syncCoordinator = mockCoordinator
            }
        }
        
        guard let searchVC = (tabBarViewControllers.first as? UINavigationController)?.topViewController as? SearchViewController,
            let cartVC = (tabBarViewControllers.last as? UINavigationController)?.topViewController as? CartViewController else {
                XCTFail("Unexpected view controller for first tab")
                return
        }
        
        XCTAssertNotNil(searchVC.syncCoordinator)
        XCTAssertNotNil(cartVC.syncCoordinator)
    }
    
}
