//
//  AddressBookViewController.swift
//  AddressBookApp
//
//  Created by CHOMINJI on 2019/11/23.
//  Copyright © 2019 cmindy. All rights reserved.
//

import UIKit

class AddressBookViewController: UITableViewController {

    // MARK: - Vars
    
    private var dataSource = ContactDataSource()
    
    @IBOutlet weak var contactSearchBar: UISearchBar!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpAttributes()
        
        dataSource.dataDidUpdated = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
}

// MARK: - Attributes

extension AddressBookViewController {
    private func setUpAttributes() {
        setUpTableView()
        setUpSearchBar()
    }
    
    private func setUpTableView() {
        tableView.dataSource = dataSource
    }
    
    private func setUpSearchBar() {
        contactSearchBar.delegate = self
        
        contactSearchBar.autocapitalizationType = .none
        contactSearchBar.autocorrectionType = .no
    }
}

// MARK: - UISearchBar

extension AddressBookViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dataSource.searchText = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            return
        }
        dataSource.searchText = searchText
        searchBar.resignFirstResponder()
    }
}
