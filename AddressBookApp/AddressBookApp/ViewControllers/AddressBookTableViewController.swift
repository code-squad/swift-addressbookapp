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
    private var contacts = ContactsInformation()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchContacts()
    }

    private func fetchContacts() {
        MGCContactStore.sharedInstance.fetchContacts({ (contacts: [CNContact]) in
            let familySortedContacts = contacts.sorted(by: { (lhs, rhs) in
                return lhs.familyName.localizedCaseInsensitiveCompare(rhs.familyName) == .orderedAscending
            })
            if familySortedContacts.count > 0 {
                self.contacts.set(with: familySortedContacts)
                DispatchQueue.main.async {
                    self.tableView.dataSource = self
                    self.tableView.reloadData()
                }
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return contacts.numberOfSections
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return contacts.header(at: section)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.numberOfRows(in: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Keyword.addressCellIdentifier.value,
                                                 for: indexPath) as! AddressBookTableViewCell
        let contact = contacts.contact(in: indexPath.section, at: indexPath.row)
        cell.setCell(with: contact)
        return cell
    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return contacts.headers
    }

}
