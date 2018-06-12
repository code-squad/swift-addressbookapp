//
//  AddressBookViewController.swift
//  AddressBookApp
//
//  Created by YOUTH2 on 2018. 6. 7..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit
import Contacts

class AddressBookViewController: UITableViewController {
    private var addressManager = AddressDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 90.0
        addressManager.fetchContacts(resetTableView)
    }

    func resetTableView() {
        DispatchQueue.main.async(execute: {() -> Void in
            self.tableView!.reloadData()
        })
    }
}


extension AddressBookViewController {

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.addressManager.count()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as! AddressTableViewCell
        cell.setCell(data: addressManager, at: indexPath.row)
        return cell
    }

}
