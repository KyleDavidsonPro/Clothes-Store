# Clothes-Store
Clothes Store Case Study

## Trello Board
https://trello.com/b/aUmBc17G/deloitte-digital-clothes-store

### Technical Notes

The solution is written in Swift 3 in Xcode 8.x and can be categorised into the following components:
1. Networking Layer
2. Core Data Layer
3. Synchronization Layer

### Networking Layer
Normally I would have used https://github.com/Alamofire/Alamofire for the networking layer however they do not support a Swift 3 version which will work on iOS 8 (only Swift 2.3) so I just wrote my own simple networking layer that wraps around URLRequests. It is driven by an `Endpoint` protocol which is implemented by light enums (see `Products.swift` & `ShoppingCart.swift`) and requests are processed via the `APIManager`

### Core Data Layer
Simple enough contains models for Products and a representation of the shopping cart. The objects are populated from the API requests through the use of `Change Processors`, a component of the `Synchronization` layer which I will discuss further on. I some `CoreDataStack.swift` utilities which contains a bunch of convenience boilerplate for core data managed objects, for example see `ManagedObjectType` protocol in this file which populates all core data managed object subclasses with some default fetch requests

### Synchronization Layer
This layer is a __very__ simplified version of a framework discussed in the book _Core Data by Florian Kugler and Daniel Eggbert_. It consists of a `SyncCoordinator` which drives executing networking requests through the `APIManager` and then translating the changes to core data. This is done through `Change Processors` which are just very specific tasks for a particular model in Core Data, for example see `ProductsDownloader` which requests all products and populates them into Core Data. 

In a real world scenario this framework would be fleshed out and used to drive offline-first functionality through change-processors that listen for changes based upon Core Data predicates, for example if the user deleted something from the shopping cart locally, you would typically have a flag on the core data model e.g. `pendingRemoteDeletion` which a `ShoppingCartRemover` change-processor would listen for and make the appropriate API request before fully deleting the object from core data. For the purpose of this App however I have not included offline support (though you can run the app offline, adding to shopping cart/deleting won't work)

### Other
Check out the `Data Handlers` in the project, it's basically a protocol driven way to implement typical NSFetchedResultsController/ Table View Delegate and DataSource behaviour across multiple view controllers without having any of the boilerplate in the View Controller itself. It's driven by generics.

### 3rd Party Dependancies
1. SwiftyJSON: https://github.com/SwiftyJSON/SwiftyJSON
2. ObjectMapper: https://github.com/Hearst-DD/ObjectMapper

#### Support
1. iOS 8+
2. Universal Application
3. UI Tests for iOS 9+
