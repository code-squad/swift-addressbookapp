//
//  AddressBookViewController.swift
//  AddressBookApp
//
//  Created by joon-ho kil on 8/21/19.
//  Copyright © 2019 길준호. All rights reserved.
//

import UIKit
import Contacts

class AddressBookViewController: UITableViewController {
    var contactDTOs = ContactDTOs()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MGCContactStore.sharedInstance.fetchContacts(({(contacts: [CNContact]) in
            self.contactDTOs = ContactDTOs(contacts: contacts)
            self.contactDTOs.sort()
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }))
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return contactDTOs.getCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as! AddressBookTableViewCell
        
        cell.putInfo(contactDTO: contactDTOs.getContactDTO(index: indexPath.row))
        
        return cell
    }
}
