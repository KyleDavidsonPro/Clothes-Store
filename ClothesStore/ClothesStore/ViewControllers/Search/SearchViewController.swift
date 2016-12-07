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
    static let productSelectSegueId = "ShowProductSegue"
    
    var managedObjectContext: NSManagedObjectContext!
    weak var syncCoordinator: SyncCoordinator!
    
    @IBOutlet var tableView: UITableView!
    
    typealias DataProvider = FetchedResultsDataProvider<SearchViewController>
    var dataSource: TableViewDataSource<SearchViewController, DataProvider, SearchTableViewCell>!
    var dataProvider: DataProvider!
    
    func setupTable() {
        self.tableView.delegate = self

        let frc = NSFetchedResultsController<NSManagedObject>(fetchRequest: Product.sortedFetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        let dataProvider = FetchedResultsDataProvider(fetchedResultsController: frc, delegate: self)
        dataSource = TableViewDataSource(tableView: tableView, dataProvider: dataProvider, delegate: self)
        
        self.dataProvider = dataProvider
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Shop"
        /// Download Products and Setup Table
        syncCoordinator.sync(changeProcessor: ProductsDownloader())
        setupTable()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let productDetailVC = segue.destination as? ProductDetailViewController {
            let product = dataSource.selectedObject! as Product
            productDetailVC.product = product
            productDetailVC.syncCoordinator = syncCoordinator
        }
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
    
    var editable: Bool {
        return false
    }
    
    func removeObject(_ object: Product)  { //no-op 
    }
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: SearchViewController.productSelectSegueId, sender: self)
    }
}

