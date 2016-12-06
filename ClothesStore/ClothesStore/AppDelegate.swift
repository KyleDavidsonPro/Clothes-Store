//
//  AppDelegate.swift
//  ClothesStore
//
//  Created by Kyle Davidson on 05/12/2016.
//  Copyright © 2016 Kyle Davidson. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var managedObjectContext: NSManagedObjectContext!
    var syncCoordinator: SyncCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        createManagedObjectContext()
        syncCoordinator = SyncCoordinator(managedObjectContext: managedObjectContext, remote: APIManager())
        
        guard let tabBarController = window?.rootViewController as? UITabBarController else {
            fatalError("Tab bar not found")
        }
        
        resolveDependencies(withTabBarController: tabBarController)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func createManagedObjectContext() {
        guard let modelUrl = Bundle.main.url(forResource: "ClothesStore", withExtension: "momd") else {
            fatalError("Error loading model from bundle")
        }
        
        guard let model = NSManagedObjectModel(contentsOf: modelUrl) else {
            fatalError("Error initializing mom from \(modelUrl)")
        }
        
        let psc = NSPersistentStoreCoordinator(managedObjectModel: model)
        managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = psc
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = urls.last
        let storeUrl = docUrl?.appendingPathComponent("ClothesStore.sqlite")
        
        do {
            try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeUrl, options: nil)
        } catch {
            fatalError("Error migrating store: \(error)")
        }
        
        //Create one record for local shopping cart if we need to
        let cartPredicate = NSPredicate(format: "%K == 1", Cart.Keys.id.rawValue)
        guard let _ = Cart.findOrFetchInContext(managedObjectContext, matchingPredicate: cartPredicate) else {
            let localShoppingCart = NSEntityDescription.insertNewObject(forEntityName: "Cart", into: managedObjectContext) as! Cart
            localShoppingCart.id = 1
            
            do {
                try managedObjectContext.save()
            } catch {
                print("Failure to save \(error)")
            }
            
            return
        }
    }
}

// MARK: - Dependancy Injection
extension AppDelegate {
    /**
     Injects in the correct dependencies to the root view controllers, This handle the case of the root views being in either split views / nav controllers
     */
    func resolveDependencies(withTabBarController tabBarController: UITabBarController) {
        guard let tabBarViewControllers = tabBarController.viewControllers else {
            fatalError("Root view controller - is not a tab bar controller")
        }
        
        for tabbedRootView in tabBarViewControllers {
            // Deals with root tabs that are a navigation controller i.e search
            if var contextSettableController = (tabbedRootView as? UINavigationController)?.topViewController as? ManagedObjectContextSettable {
                contextSettableController.managedObjectContext = managedObjectContext
            }
            
            if var syncSettableCoordinator = (tabbedRootView as? UINavigationController)?.topViewController as? SyncCoordinatorSettable {
                syncSettableCoordinator.syncCoordinator = syncCoordinator
            }
            
            // Deals with root tabs that are single views i.e. wishlist
            if var contextSettableController = tabbedRootView as? ManagedObjectContextSettable {
                contextSettableController.managedObjectContext = managedObjectContext
            }
            
            if var syncSettableCoordinator = tabbedRootView as? SyncCoordinatorSettable {
                syncSettableCoordinator.syncCoordinator = syncCoordinator
            }
        }
    }
}


