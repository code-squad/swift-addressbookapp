//
//  AddressBookViewController.swift
//  AddressBookApp
//
//  Created by yuaming on 23/04/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import UIKit

class AddressBookViewController: UITableViewController {
    private let cellIndentifier = "addressCell"
    private let addressCellHeight = CGFloat(90)
    private var contactDataManager: ContactDataManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactDataManager.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIndentifier, for: indexPath) as? AddressTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setContact(contactDataManager[indexPath.row])

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return addressCellHeight
    }
}

// MARK: - Private functions of AddressBookViewController
private extension AddressBookViewController {
    @objc func updateTableView(notification: Notification) {
        guard let contactDataManager = notification.object as? ContactDataManager else {
            return
        }
        
        self.contactDataManager = contactDataManager
        self.tableView.reloadData()
    }
    
    func setup() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateTableView(notification:)), name: Notification.Name.contactDataManager, object: nil)
        
        self.contactDataManager = ContactDataManager.share()
        self.contactDataManager.checkAccess()
    }
}
