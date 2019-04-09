//
//  AddressBookViewController.swift
//  AddressBookApp
//
//  Created by 조재흥 on 19. 4. 1..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

class AddressBookViewController: UITableViewController {

    //MARK: - Properties
    //MARK: IBOutlet
    
    @IBOutlet var contactTableView: UITableView!
    
    //MARK: Private
    
    private var contacts = Addresses()
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let filteredAddressDataSource = FilteredAddressDataSource()
    private let addressDataSource = AddressDataSource()
    
    //MARK: - Methods
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredAddressDataSource.attach(contacts: contacts)
        addressDataSource.attach(contacts: contacts)

        contactTableView.dataSource = addressDataSource
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadTableView),
                                               name: .updatedContacts,
                                               object: nil)
    }
    
    //MARK: @objc
    
    @objc private func reloadTableView(_ noti: Notification) {
        contactTableView.reloadData()
    }
}

extension AddressBookViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        if searchController.isFiltering() {
            contactTableView.dataSource = filteredAddressDataSource
        } else {
            contactTableView.dataSource = addressDataSource
        }
        contacts.filterContactWith(searchText: searchText)
    }
}

extension UISearchBar {
    func isEmpty() -> Bool {
        return text?.isEmpty ?? true
    }
}

extension UISearchController {
    func isFiltering() -> Bool {
        return self.isActive && !self.searchBar.isEmpty()
    }
}
