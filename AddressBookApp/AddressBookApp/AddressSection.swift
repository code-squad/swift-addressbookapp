//
//  AddressSection.swift
//  AddressBookApp
//
//  Created by 조재흥 on 19. 4. 4..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

struct AddressSection {
    let title: String
    private var address: [MGCContact]
    
    subscript(index: Int) -> MGCContact? {
        guard 0 <= index, index < address.count else { return nil }
        return address[index]
    }
    
    init(title: String, contacts: [MGCContact]) {
        self.title = title
        self.address = contacts
    }
    
    func count() -> Int {
        return address.count
    }
    
    func filteredContacts(with searchText: String) -> [MGCContact] {
        let extracter = InitialConsonantExtracter()
        return address.filter({ (mgcContact) -> Bool in
            mgcContact.firstName.lowercased().contains(searchText.lowercased()) ||
            extracter.initialConsonants(of: mgcContact.firstName).contains(searchText)
        })
    }
}
