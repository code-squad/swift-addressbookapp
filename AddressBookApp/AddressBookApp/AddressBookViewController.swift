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
    private lazy var addresses = Addresses(with: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureObserver()
    }
    
    private func configureObserver() {
        let reloadData = Notification.Name(Key.reloadData)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: reloadData, object: nil)
    }
    
    @objc private func reload() {
        self.tableView.reloadData()
    }
}

// for Cell
extension AddressBookViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Key.addressTableViewCell, for: indexPath) as! AddressTableViewCell
        let address = addresses.addressInSection(sectionIndex: indexPath.section, rowIndex: indexPath.row)
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
        return addresses.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return addresses.sectionName(at: section)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresses.countInSection(at: section)
    }
}

// for indexTitle
extension AddressBookViewController {
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        var list = [String]()
        for consonant in Consonant.allCases {
            list.append(consonant.description)
        }
        return list
    }
}
