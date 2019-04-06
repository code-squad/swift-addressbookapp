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
    
    //MARK: - Properties
    
    let indexTitles = ["ㄱ", "ㄴ", "ㄷ", "ㄹ", "ㅁ", "ㅂ", "ㅅ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "#",]
    
    //MARK: Private
    
    private var addressSection = [AddressSection]()
    
    //MARK: - Methods
    //MARK: Subscript
    
    subscript(index: Int) -> AddressSection? {
        guard 0 <= index, index < addressSection.count else { return nil }
        return addressSection[index]
    }
    
    //MARK: Initialization
    
    init() {
        MGCContactStore.sharedInstance.fetchContacts { (contacts) in
            var sections = [String: [MGCContact]]()
            let extracter = InitialConsonantExtracter()

            for contact in contacts {
                let mgcContact = MGCContactStoreUtilities().parse(contact)
                let firstName = mgcContact.firstName
                guard let title = extracter.extract(word: firstName) else { continue }
                if sections[title] == nil {
                    sections[title] = [MGCContact]()
                }
                sections[title]?.append(mgcContact)
            }
            
            for indexTitle in self.indexTitles {
                guard let section = sections[indexTitle] else { continue }
                self.addressSection.append(AddressSection(title: indexTitle,
                                                          contacts: section))
            }
            
            NotificationCenter.default.post(name: .updatedContacts, object: self)
        }
    }
    
    //MARK: Instance
    
    func count() -> Int {
        return self.addressSection.count
    }
}

extension NSNotification.Name {
    static let updatedContacts = Notification.Name(rawValue: "updatedContacts")
}

extension CNContact {
    static let familyNameSortKey = "familyName"
    static let givenNameSortKey = "givenName"
}
