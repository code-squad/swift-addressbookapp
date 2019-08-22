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
    var contactsDTO = [ContactDTO]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MGCContactStore.sharedInstance.fetchContacts(({(contacts: [CNContact]) in
            self.contactsDTO = contacts.map({ (contact) -> ContactDTO in
                return ContactDTO(contact: contact)
            })
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }))
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return contactsDTO.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as! AddressBookTableViewCell
        
        cell.putInfo(contactDTO: contactsDTO[indexPath.row])
        
        return cell
    }
}
