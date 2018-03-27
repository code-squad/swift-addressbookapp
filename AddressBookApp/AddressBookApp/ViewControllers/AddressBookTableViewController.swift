//
//  AddressBookTableViewController.swift
//  AddressBookApp
//
//  Created by TaeHyeonLee on 2018. 3. 27..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import UIKit
import Contacts

class AddressBookTableViewController: UITableViewController {
    private var contacts = [CNContact]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.dataSource = self
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        MGCContactStore.sharedInstance.fetchContacts({ (contacts: [CNContact]) in
            if contacts.count > 0 {
                self.contacts = contacts
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as! AddressBookTableViewCell
        let contact = contacts[indexPath.row]
        cell.setCell(with: contact)
        return cell
    }

}
