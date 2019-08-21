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
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MGCContactStore.sharedInstance.getContactsCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as! AddressBookTableViewCell

        MGCContactStore.sharedInstance.fetchContacts(({(contacts: [CNContact]) in
            let contact = contacts[indexPath.row]
            
            cell.nameLabel.text = contact.familyName + " " + contact.givenName
            cell.telLabel.text = (contact.phoneNumbers[0].value ).stringValue
            
            if let emailAddress = contact.emailAddresses.first {
                cell.emailLabel.text = emailAddress.value as String
            }
            
            if let imageData = contact.imageData {
                cell.profile.image = UIImage(data: imageData)
            }
        }))
        
        return cell
    }
}
