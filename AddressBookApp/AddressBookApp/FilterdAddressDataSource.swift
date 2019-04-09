//
//  FilterdAddressDataSource.swift
//  AddressBookApp
//
//  Created by 조재흥 on 19. 4. 9..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

class FilteredAddressDataSource: NSObject, UITableViewDataSource {
    
    weak private var contacts: Addresses?
    
    func attach(contacts: Addresses) {
        self.contacts = contacts
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contacts?.filterdCount() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddressTableViewCell.identifier, for: indexPath)
        
        guard let addressCell = cell as? AddressTableViewCell,
            let mgcContact = contacts?.filteredAddress(index: indexPath.row) else { return cell }
        
        addressCell.show(contact: mgcContact)
        return addressCell
    }
}
