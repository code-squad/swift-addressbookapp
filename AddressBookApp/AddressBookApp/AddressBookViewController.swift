//
//  AddressBookViewController.swift
//  AddressBookApp
//
//  Created by oingbong on 30/11/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit
import Contacts

class AddressBookViewController: UITableViewController {
    private lazy var addressList = AddressList(with: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// for Cell
extension AddressBookViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addressTableViewCell", for: indexPath) as! AddressTableViewCell
        let address = addressList.addressesGroup[indexPath.section].sectionObjects[indexPath.row]
        cell.configure(from: address)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

// for Section
extension AddressBookViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return addressList.addressesGroup.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return addressList.addressesGroup[section].sectionName
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressList.addressesGroup[section].sectionObjects.count
    }
}
