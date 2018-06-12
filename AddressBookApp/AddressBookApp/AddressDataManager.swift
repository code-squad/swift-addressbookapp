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
    private var addressList = [AddressData]()

    func count() -> Int {
        return self.addressList.count
    }

    func data(at: Int) -> AddressData {
        return self.addressList[at]
    }

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
                        self.addressList = contacts
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

}

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
