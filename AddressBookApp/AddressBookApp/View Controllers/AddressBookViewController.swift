//
//  AddressBookViewController.swift
//  AddressBookApp
//
//  Created by CHOMINJI on 2019/11/23.
//  Copyright © 2019 cmindy. All rights reserved.
//

import Contacts
import UIKit

class AddressBookViewController: UITableViewController {

    // MARK: - Vars
    
    var contacts: [Contact] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MGCContactStore.sharedInstance.fetchContacts { contacts in
            self.contacts = contacts.map { Contact(contact: $0) }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddressCell.reuseID, for: indexPath) as? AddressCell else {
            return .init()
        }
        
        let contact = contacts[indexPath.row]
        cell.configure(contact)
        
        return cell
    }
}
