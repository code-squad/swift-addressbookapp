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
    private var titles: [String] = [String]()
    private var contacts: [Contact] = [Contact]()
    private var contactData: [[Contact]] = [[Contact]]()
    
    func checkAccess() {
        mgcContactStoreInstance.checkContactsAccess({ (accessGranted: Bool) in
            if accessGranted {
                self.fetchAllContacts()
            }
        })
    }
    
    func numberOfCells(_ sectionIndex: Int) -> Int {
        return contactData[sectionIndex].count
    }
    
    func numberOfSections() -> Int {
        return contactData.count
    }
    
    func bringTitles() -> [String] {
        return self.titles.filterDuplicatedElements().sorted()
    }
    
    subscript(_ titleIndex: Int) -> String {
        return bringTitles()[titleIndex]
    }

    subscript(_ sectionIndex: Int) -> [Contact] {
        return contactData[sectionIndex]
    }
    
    subscript(_ sectionIndex: Int, index: Int) -> Contact {
        return contactData[sectionIndex][index]
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
            
            contacts.forEach({ (value: CNContact) in
                self.addContects(value)
                self.addTitles(value.familyName)
            })
            
            self.createContactData()
            
            NotificationCenter.default.post(name: Notification.Name.contactDataManager, object: self)
        })
    }
    
    func createContactData() {
        let _titles = bringTitles()
        
        _titles.forEach({ (title: String) in
            self.contactData.append(createContactDatas(title))
        })
    }
    
    func createContactDatas(_ comparedTitle: String) -> [Contact] {
        var values: [Contact] = [Contact]()
        
        self.contacts.forEach({ (contact: Contact) in
            if String(contact.lastName.trimmingCharacters(in: [" "]).first ?? " ").hasPrefix(comparedTitle) {
                values.append(contact)
            }
        })
        
        return values
    }
    
    func addContects(_ value: CNContact) {
        let lastName = value.familyName
        let firstName = value.givenName
        let imageData: Data? = value.thumbnailImageData
        let phoneNumber = value.phoneNumbers.first?.value.stringValue ?? ""
        let email = value.emailAddresses.first?.value as String? ?? ""
        self.contacts.append(Contact(lastName, firstName, phoneNumber, email, imageData))
    }
    
    func addTitles(_ title: String) {
        let firstCharacter = String(title.trimmingCharacters(in: [" "]).first ?? " ")
        self.titles.append(firstCharacter)
    }
}
