//
//  Contacts.swift
//  AddressBookApp
//
//  Created by 조재흥 on 19. 4. 1..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation
import Contacts

class Contacts {
    private var contacts = [CNContact]() {
        didSet {
            NotificationCenter.default.post(name: .updatedContacts, object: self)
        }
    }
    
    init() {
        MGCContactStore.sharedInstance.fetchContacts { (contacts) in
            self.contacts += contacts
        }
    }
    
    func count() -> Int {
        return self.contacts.count
    }
}

extension NSNotification.Name {
    static let updatedContacts = Notification.Name(rawValue: "updatedContacts")
}
