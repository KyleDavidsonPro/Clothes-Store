//
//  CoreDataStack.swift
//  ClothesStore
//
//  Created by Kyle Davidson on 06/12/2016.
//  Copyright © 2016 Kyle Davidson. All rights reserved.
//

import CoreData

/// Base protocol for all models. Each Core Data model should adopt it
public protocol ManagedObjectType: class {
    /// Returns entity name
    static var entityName: String { get }
    /// Returns default NSSortDescriptor
    static var defaultSortDescriptors: [NSSortDescriptor] { get }
    /// Returns default NSPredicate
    static var defaultPredicate: NSPredicate { get }
}

/// Default implementation of ManagedObjectType
extension ManagedObjectType {
    /// Returns empty array of NSSortDescriptors
    public static var defaultSortDescriptors: [NSSortDescriptor] {
        return []
    }
    
    /// Returns NSFetchRequest which use defaultSortDescriptors
    public static var sortedFetchRequest: NSFetchRequest<NSManagedObject> {
        let request = NSFetchRequest<NSManagedObject>(entityName: entityName)
        request.sortDescriptors = defaultSortDescriptors
        return request
    }
    
    /// Returns NSPredicate which will match all results
    public static var defaultPredicate: NSPredicate {
        let predicate = NSPredicate(value: true)
        return predicate
    }
}

/// Bog Standard Core Data Boiler Plate
extension ManagedObjectType {    
    /// Try to find and materialize enitity which match given predicate
    public static func findOrFetchInContext(_ moc: NSManagedObjectContext, matchingPredicate predicate: NSPredicate) -> Self? {
        guard let obj = materializedObjectInContext(moc, matchingPredicate: predicate) else {
            return fetchInContext(moc) { request in
                request.predicate = predicate
                request.returnsObjectsAsFaults = false
                request.fetchLimit = 1
                }.first
        }
        return obj
    }
    /**
     Iterates over the context’s registeredObjects set, which contains all managed objects the context currently knows about.
     It does this until it finds one that is not a fault, is of the correct type, and matches a given predicate:
     */
    public static func materializedObjectInContext(_ moc: NSManagedObjectContext, matchingPredicate predicate: NSPredicate) -> Self? {
        for obj in moc.registeredObjects where !obj.isFault {
            guard let res = obj as? Self,
                predicate.evaluate(with: res) else { continue }
            return res
        }
    
        return nil
    }

    /**
     Helper method which makes easier to execute fetch requests.
     It combines the configuration and the execution of a fetch request.
     It also casts the result to the correct type
     */
    public static func fetchInContext(_ moc: NSManagedObjectContext, configurationBlock: (NSFetchRequest<NSManagedObject>) -> () = { _ in }) -> [Self] {
        let request = NSFetchRequest<NSManagedObject>(entityName: Self.entityName)
        var results: [AnyObject] = []
        configurationBlock(request)
        
        do {
            results = try moc.fetch(request)
        } catch let error {
            fatalError("Exception was thrown while executing FetchRequest = \(request). Error message = \(error)")
        }
        
        guard let result = results as? [Self] else {
            fatalError("Fetched objects have wrong type")
        }
        return result
    }
}

extension NSManagedObjectContext {
    /**
     Helper methods to clean up the code. It insert new objects without having to manually downcast the result every time, and without having to reference the entity type by its name.
     For this, we leverage the static entityName property that we introduced in the ManagedObjectType protocol.
     */
    public func insertObject<A: ManagedObjectType> () -> A {
        guard let obj = NSEntityDescription.insertNewObject(forEntityName: A.entityName, into: self) as? A else {
            fatalError("Wrong object type")
        }
        return obj
    }
    
    public func trySave() {
        do {
            try self.save()
        } catch {
            print("Failure to save \(error)")
        }
    }
}
