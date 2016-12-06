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
    weak var syncCoordinator: SyncCoordinator!
    
    @IBOutlet var tableView: UITableView!
    
    typealias DataProvider = FetchedResultsDataProvider<SearchViewController>
    var dataSource: TableViewDataSource<SearchViewController, DataProvider, SearchTableViewCell>!
    var dataProvider: DataProvider!
    
    func setupTable() {
        tableView.contentInset = UIEdgeInsetsMake(20, 0, 49, 0)
        
        let frc = NSFetchedResultsController<NSManagedObject>(fetchRequest: Product.sortedFetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        let dataProvider = FetchedResultsDataProvider(fetchedResultsController: frc, delegate: self)
        dataSource = TableViewDataSource(tableView: tableView, dataProvider: dataProvider, delegate: self)
        self.dataProvider = dataProvider
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        syncCoordinator.sync(changeProcessor: ProductsDownloader())
        setupTable()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - Data Provider Delegate
extension SearchViewController: DataProviderDelegate {
    func dataProviderDidUpdate(_ updates: [DataProviderUpdate<Product>]?) {
        self.dataSource.processUpdates(updates: updates)
    }
}

// MARK: - Data Source Delegate
extension SearchViewController: DataSourceDelegate {
    func cellIdentifierForObject(_ object: Product) -> String {
        return "SearchTableViewCell"
    }
}

