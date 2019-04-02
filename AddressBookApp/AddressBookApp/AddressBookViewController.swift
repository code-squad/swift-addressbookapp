//
//  AddressBookViewController.swift
//  AddressBookApp
//
//  Created by 조재흥 on 19. 4. 1..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

class AddressBookViewController: UITableViewController {

    //MARK: - Properties
    //MARK: IBOutlet
    
    @IBOutlet var contactTableView: UITableView!
    
    //MARK: Private
    
    private var contacts = Addresses()
    private let contactCellIdentifier = "addressCell"
    
    //MARK: - Methods
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadTableView),
                                               name: .updatedContacts,
                                               object: nil)
    }
    
    //MARK: @objc
    
    @objc private func reloadTableView(_ noti: Notification) {
        contactTableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contacts.count()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: contactCellIdentifier, for: indexPath)
        
        guard let addressCell = cell as? AddressTableViewCell,
            let mgcContact = contacts.mgcContact(with: indexPath.row) else { return cell }
        
        addressCell.show(contact: mgcContact)
        // Configure the cell...

        return addressCell
    }
}
