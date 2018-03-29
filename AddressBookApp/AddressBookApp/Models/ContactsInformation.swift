//
//  ContactsInformation.swift
//  AddressBookApp
//
//  Created by TaeHyeonLee on 2018. 3. 29..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation
import Contacts

class ContactsInformation {
    private var contacts = [[CNContact]]()
    private var headers = [Character]()

    func set(with allContacts: [CNContact]) {
        allContacts.forEach { add(contact: $0) }
    }

    private func add(contact: CNContact) {
        let index = headerIndex(of: "\(contact.familyName) \(contact.givenName)")
        if index < contacts.count {
            contacts[index].append(contact)
            contacts[index].sort(by: { (lhs, rhs) in
                lhs.givenName.localizedCaseInsensitiveCompare(rhs.givenName) == .orderedAscending

            })
        } else if index == contacts.count {
            contacts.append([contact])
        }
    }

    private func headerIndex(of name: String) -> Int {
        let name = name.trimmingCharacters(in: [" "]).first ?? "_"
        guard let headerIndex = headers.index(of: name) else {
            headers.append(name)
            return headers.count - 1
        }
        return headerIndex
    }

    var numberOfSections: Int {
        return contacts.count
    }

    func header(at section: Int) -> String? {
        guard headers.count > section else { return nil }
        return String(headers[section])
    }

    func numberOfRows(in section: Int) -> Int {
        return contacts[section].count
    }

    func contact(in section: Int, at row: Int) -> CNContact {
        return contacts[section][row]
    }
}
