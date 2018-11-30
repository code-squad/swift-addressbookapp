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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AddressTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "addressTableViewCell", for: indexPath) as! AddressTableViewCell
        let address = addressList[indexPath.row]
        cell.configure(from: address)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

}
