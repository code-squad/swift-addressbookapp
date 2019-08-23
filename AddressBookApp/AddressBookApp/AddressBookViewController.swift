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
            DispatchQueue.main.async {
                self.contactDTOs = ContactDTOs(contacts: contacts)
                self.contactDTOs.sort()
                self.contactDTOs.makeInitialitys()
                self.tableView.reloadData()
            }
        }))
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return contactDTOs.getSessionCount()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return contactDTOs.getSessionHeader(index: section)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactDTOs.getCellCount(index: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as! AddressBookTableViewCell
        
        let contactDTO = contactDTOs.getContactDTO(sessionIndex: indexPath.section, cellIndex: indexPath.row)
        cell.putInfo(contactDTO: contactDTO)
        
        return cell
    }
}
