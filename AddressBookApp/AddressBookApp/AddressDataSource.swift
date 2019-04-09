//
//  AddressDataSource.swift
//  AddressBookApp
//
//  Created by 조재흥 on 19. 4. 9..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

class AddressDataSource: NSObject, UITableViewDataSource {
    
    weak private var contacts: Addresses?
    
    func attach(contacts: Addresses) {
        self.contacts = contacts
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contacts?[section]?.count() ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return contacts?.count() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddressTableViewCell.identifier, for: indexPath)
        
        guard let addressCell = cell as? AddressTableViewCell,
            let addressSection = contacts?[indexPath.section],
            let mgcContact = addressSection[indexPath.row] else { return cell }

        addressCell.show(contact: mgcContact)
        return addressCell
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return contacts?.indexOfTitle(index) ?? -1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let addressSection = contacts?[section] else { return nil }
        return addressSection.title
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return contacts?.indexTitles
    }
}
