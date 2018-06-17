//
//  AddressDataManager.swift
//  AddressBookApp
//
//  Created by YOUTH2 on 2018. 6. 8..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation
import Contacts

class AddressDataManager {
    private var list = [AddressData]()
    private var matrix = AddressSets()

    func fetchContacts(_ handler: (@escaping () -> Void)) {
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
                        var contacts = [AddressData]()
                        try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointer) in
                            contacts.append(AddressData(contact))
                        })
                        self.list = contacts
                        self.matrix = AddressSets(contacts)
                    } catch let error {
                        print("Failed to enumerate:", error)
                    }
                } else {
                    print("Access Denied")
                }
            }
            handler()
        }
    }

    func countOfAvailableConsonant() -> Int {
        return matrix.countOfConsonant()
    }

    func sectionKeys() -> [String] {
        return matrix.keys()
    }

    func count(of letter: String) -> Int {
        return matrix.count(of: letter)
    }

    func data(of section: String, at row: Int) -> AddressData {
        return matrix.data(section: section, row: row)
    }

}

struct AddressData: Comparable {
    static func < (lhs: AddressData, rhs: AddressData) -> Bool {
        return lhs.name <= rhs.name
    }

    var givenName: String
    var familyName: String
    var phoneNumber: String
    var emailAddress: String
    var profileImage: Data?
    var name: String {
        return familyName + " " + givenName
    }

    init(_ contact: CNContact) {
        self.givenName = contact.givenName ?? " "
        self.familyName = contact.familyName ?? " "
        self.phoneNumber = contact.phoneNumbers.first?.value.stringValue ?? "no phone"
        self.emailAddress = (contact.emailAddresses.first?.value) as String? ?? "no email"
        self.profileImage = contact.imageData
    }

}
