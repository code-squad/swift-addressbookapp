//
//  contactDTOs.swift
//  AddressBookApp
//
//  Created by joon-ho kil on 8/23/19.
//  Copyright © 2019 길준호. All rights reserved.
//

import Foundation
import Contacts

struct ContactDTOs {
    var contactDTOs = [ContactDTO]()
    
    init() {
        return
    }
    
    init(contacts: [CNContact]) {
        self.contactDTOs = contacts.map({ (contact) -> ContactDTO in
            return ContactDTO(contact: contact)
        })
    }
    
    mutating func sort() {
        self.contactDTOs.sort(by: { (left, right) -> Bool in
            return left < right
        })
    }
    
    func getCount() -> Int {
        return contactDTOs.count
    }
    
    func getContactDTO(index: Int) -> ContactDTO {
        return contactDTOs[index]
    }
}
