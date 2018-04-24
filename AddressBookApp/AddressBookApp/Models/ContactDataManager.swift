//
//  ContactDataManager.swift
//  AddressBookApp
//
//  Created by yuaming on 24/04/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation
import Contacts
import UIKit

class ContactDataManager {
    private static let sharedInstance = ContactDataManager()
    private let mgcContactStoreInstance = MGCContactStore.sharedInstance
    private var contacts: [Contact] = [Contact]()
    
    func checkAccess() {
        mgcContactStoreInstance.checkContactsAccess({ (accessGranted: Bool) in
            if accessGranted {
                self.fetchAllContacts()
            }
        })
    }
    
    var count: Int {
        return contacts.count
    }
    
    subscript(_ index: Int) -> Contact {
        return contacts[index]
    }
    
    static func share() -> ContactDataManager {
        return sharedInstance
    }
}

// MARK: - Private functions of ContactDataManager
private extension ContactDataManager {
    func fetchAllContacts() {
        mgcContactStoreInstance.fetchContacts({ (contacts: [CNContact]) in
            guard contacts.count > 0 else { return }
            
            contacts.enumerated().forEach({ (index: Int, value: CNContact) in
                let lastName = value.familyName
                let firstName = value.givenName
                let imageData: Data? = value.thumbnailImageData
                let phoneNumber = value.phoneNumbers.first?.value.stringValue ?? ""
                let email = value.emailAddresses.first?.value as String? ?? ""
                
                self.contacts.append(Contact(lastName, firstName, phoneNumber, email, imageData))
            })
            
            NotificationCenter.default.post(name: Notification.Name.contactDataManager, object: self)
        })
    }
}
