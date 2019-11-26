//
//  ContactDataSource.swift
//  AddressBookApp
//
//  Created by CHOMINJI on 2019/11/26.
//  Copyright © 2019 cmindy. All rights reserved.
//

import UIKit
import Contacts

class ContactDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Vars
    
    private var contacts: [Contact] = [] {
        didSet {
            contactsDidFetched?()
        }
    }
    
    // MARK: - Closures
    
    var contactsDidFetched: (() -> Void)?
    
    // MARK: - Initializer
    
    override init() {
        super.init()
        
        MGCContactStore.sharedInstance.fetchContacts { contacts in
            self.contacts = contacts.map { Contact(contact: $0) }
        }
    }
    
    // MARK: - UITableView DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddressCell.reuseID, for: indexPath) as? AddressCell else {
            return .init()
        }
        
        let contact = contacts[indexPath.row]
        cell.configure(contact)
        
        return cell
    }
}
