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
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        
        dataSource.contactsDidFetched = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
}
