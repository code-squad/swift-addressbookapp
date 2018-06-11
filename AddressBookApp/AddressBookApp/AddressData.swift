//
//  ContactData.swift
//  AddressBookApp
//
//  Created by YOUTH2 on 2018. 6. 8..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation
import Contacts

struct AddressData {
    var givenName: String
    var familyName: String
    var phoneNumber: String
    var emailAddress: String
    var profileImage: Data?

    init(_ contact: CNContact) {
        self.givenName = contact.givenName ?? " "
        self.familyName = contact.familyName ?? " "
        self.phoneNumber = contact.phoneNumbers.first?.value.stringValue ?? "no phone"
        self.emailAddress = (contact.emailAddresses.first?.value) as String? ?? "no email"
        self.profileImage = contact.imageData
    }
}

class MyContactsData {
    private var contacts: [AddressData]

    init(contacts: [AddressData]) {
        self.contacts = contacts
    }

    func data(at: Int) -> AddressData {
        return self.contacts[at]
    }

    func count() -> Int {
        return self.contacts.count
    }
}
