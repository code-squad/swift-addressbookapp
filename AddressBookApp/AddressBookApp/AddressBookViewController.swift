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

    private func resetTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}


extension AddressBookViewController {

    // MARK: - Table view delegate

    // UIView타입으로 header에 사용할 뷰를 리턴
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        label.text = " " + addressManager.consonantLetter(at: section)
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        return label
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return addressManager.countOfAvailableConsonant()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard addressManager.sectionKeys().count != 0 else { return 0 }
        return self.addressManager.count(of: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as! AddressTableViewCell
        cell.setCell(data: addressManager.data(of: indexPath.section, at: indexPath.row))
        return cell
    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return addressManager.sectionKeys()
    }

}
