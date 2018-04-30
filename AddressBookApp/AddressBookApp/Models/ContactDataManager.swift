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

// MARK: - Functions of ContactDataManager
private extension ContactDataManager {
    func fetchAllContacts() {
        mgcContactStoreInstance.fetchContacts({ (contacts: [CNContact]) in
            guard contacts.count > 0 else { return }
            
            contacts.forEach({ (value: CNContact) in
                self.appendContacts(value)
                self.appendTitles(value.familyName)
            })
            
            self.createContactData()
            
            NotificationCenter.default.post(name: Notification.Name.contactDataManager, object: self)
        })
    }
    
    func createContactData() {
        bringTitles().forEach({ (title: String) in
            self.contactData.append(createContactDataElements(title))
        })
    }
    
    func createContactDataElements(_ comparedTitle: String) -> [Contact] {
        var elements: [Contact] = [Contact]()
        
        self.contacts.forEach({ (contact: Contact) in
            if seperateWords(contact.lastName).hasPrefix(comparedTitle) {
                elements.append(contact)
            }
        })
        
        return elements
    }
}

// MARK: - Functions of contacts
private extension ContactDataManager {
    func appendContacts(_ value: CNContact) {
        let lastName = value.familyName
        let firstName = value.givenName
        let imageData: Data? = value.thumbnailImageData
        let phoneNumber = value.phoneNumbers.first?.value.stringValue ?? ""
        let email = value.emailAddresses.first?.value as String? ?? ""
        self.contacts.append(Contact(lastName, firstName, phoneNumber, email, imageData))
    }
}

// MARK: - Functions of titles
private extension ContactDataManager {
    func appendTitles(_ words: String) {
        let word = self.seperateWords(words)
        self.titles.append(word)
    }
    
    func isKorean(_ words: String) -> Bool {
        return words.matchPatterns(Words.patternOfKorean)
    }
    
    func seperateWords(_ words: String) -> String {
        let word = String(words.trimmingCharacters(in: [" "]).first ?? " ")
        
        guard isKorean(words) else {
            return word
        }
        
        let wordScalas = word.unicodeScalars
        let wordUnicode = Int(wordScalas[wordScalas.startIndex].value)
        let initialScalas = Words.startedKoreanWord.unicodeScalars
        let initialUnicode = Int(initialScalas[initialScalas.startIndex].value)
        let index = ((wordUnicode - initialUnicode) / 28) / 21
        return Words.initialConsonants[index]
    }
    
    struct Words {
        static let initialConsonants = ["ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]
        static let patternOfKorean = "[가-힣]"
        static let startedKoreanWord = "가"
    }
}
