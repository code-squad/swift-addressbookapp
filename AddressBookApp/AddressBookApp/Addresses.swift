//
//  Contacts.swift
//  AddressBookApp
//
//  Created by 조재흥 on 19. 4. 1..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation
import Contacts

class Addresses {
    private var contacts = [CNContact]()
    
    init() {
        MGCContactStore.sharedInstance.fetchContacts { (contacts) in
            self.contacts += contacts
            NotificationCenter.default.post(name: .updatedContacts, object: self)
        }
    }
    
    func count() -> Int {
        return self.contacts.count
    }
    
    func mgcContact(with number: Int) -> MGCContact? {
        guard 0 <= number, number < contacts.count else { return nil }
        let cnContact = contacts[number]
        let mgcContact = MGCContactStoreUtilities().parse(cnContact)
        return mgcContact
    }
}

extension NSNotification.Name {
    static let updatedContacts = Notification.Name(rawValue: "updatedContacts")
}
