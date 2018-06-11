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
    private var contacts = [AddressData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 90.0
        fetchContacts()
    }

    // MARK: Fetch Contacts
    private func fetchContacts() {

        let store = CNContactStore()
        store.requestAccess(for: .contacts) { (permitted, error) in
            if let error = error {
                print("Failed to Request access:", error)
                return
            } else {
                if permitted {
                    let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactEmailAddressesKey, CNContactImageDataKey]
                    let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])

                    do {
                        var addressData = [AddressData]()
                        try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointer) in
                            addressData.append(AddressData(contact))
                        })
                        self.contacts = addressData
                    } catch let error {
                        print("Failed to enumerate:", error)
                    }
                } else {
                    print("Access Denied")
                }
            }
            self.resetTableView()
        }
    }

    func resetTableView() {
        DispatchQueue.main.async(execute: {() -> Void in
            self.tableView!.reloadData()
        })
    }
}



extension AddressBookViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contacts.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as! AddressTableViewCell
        cell.status = self.contacts[indexPath.row]
        return cell
    }

}
