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
    
    let indexTitles = ["ㄱ", "ㄴ", "ㄷ", "ㄹ", "ㅁ", "ㅂ", "ㅅ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "#",]
    
    private var contacts = [CNContact]()
    private(set) var sectionTitles = [String]()
    
    init() {
        MGCContactStore.sharedInstance.fetchContacts { (contacts) in
            self.contacts += contacts
            self.sort()
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
    
    func sort() {
        let familyNameSortDescriptor = NSSortDescriptor(key: CNContact.familyNameSortKey, ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
        let givenNameSortDescriptor = NSSortDescriptor(key: CNContact.givenNameSortKey, ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
        let sortDescriptors = [familyNameSortDescriptor, givenNameSortDescriptor]
        let sortedContacts = (contacts as NSArray).sortedArray(using: sortDescriptors)
        guard let contacts = sortedContacts as? [CNContact] else { return }
        self.contacts = contacts
    }
}

extension NSNotification.Name {
    static let updatedContacts = Notification.Name(rawValue: "updatedContacts")
}

extension CNContact {
    static let familyNameSortKey = "familyName"
    static let givenNameSortKey = "givenName"
}
