//
//  CartViewController.swift
//  ClothesStore
//
//  Created by Kyle Davidson on 05/12/2016.
//  Copyright © 2016 Kyle Davidson. All rights reserved.
//

import UIKit
import CoreData

class CartViewController: UIViewController, ManagedObjectContextSettable, SyncCoordinatorSettable {
    var deleteButton: UIBarButtonItem!
    
    var managedObjectContext: NSManagedObjectContext!
    weak var syncCoordinator: SyncCoordinator!
    
    @IBOutlet var tableView: UITableView!
    
    typealias DataProvider = FetchedResultsDataProvider<CartViewController>
    var dataSource: TableViewDataSource<CartViewController, DataProvider, CartTableViewCell>!
    var dataProvider: DataProvider!
    
    func setupTable() {
        tableView.delegate = self
        let frc = NSFetchedResultsController<NSManagedObject>(fetchRequest: Product.productsInCart(), managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        let dataProvider = FetchedResultsDataProvider(fetchedResultsController: frc, delegate: self)
        dataSource = TableViewDataSource(tableView: tableView, dataProvider: dataProvider, delegate: self)
        self.dataProvider = dataProvider
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Cart"
        setupTable()
        navigationItem.leftBarButtonItem = editButtonItem
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        deleteButton = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(self.deleteProducts))
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func deleteProducts() {
        guard let selectedPaths = tableView.indexPathsForSelectedRows else {
            return
        }
        
        /// Locking the UI is obviously not ideal but quick win for MVP
        self.tableView.isUserInteractionEnabled = false
        for path in selectedPaths {
            let product: Product = dataProvider.object(at: path)
            removeObject(product)
        }
        self.tableView.isUserInteractionEnabled = true
    }
}

// MARK: - Data Provider Delegate
extension CartViewController: DataProviderDelegate {
    func dataProviderDidUpdate(_ updates: [DataProviderUpdate<Product>]?) {
        self.dataSource.processUpdates(updates: updates)
    }
}

// MARK: - Data Source Delegate
extension CartViewController: DataSourceDelegate {
    func cellIdentifierForObject(_ object: Product) -> String {
        return "CartTableViewCell"
    }
    
    var editable: Bool {
        return true
    }
    
    func removeObject(_ object: Product) {
        syncCoordinator.sync(changeProcessor: CartRemover(product: object))
    }
}

// MARK: - Table View Delegate
extension CartViewController: UITableViewDelegate {
    override func setEditing(_ editing: Bool, animated: Bool) {
        if editing {
            navigationItem.rightBarButtonItem = deleteButton
        } else {
            navigationItem.rightBarButtonItem = nil
        }
        
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
           return UITableViewCellEditingStyle.delete
    }
}

