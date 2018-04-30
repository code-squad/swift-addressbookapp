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
    private var contactDatas: [[Contact]] = [[Contact]]()
    private(set) var titles: [String] = [String]()
    
    func checkAccess() {
        mgcContactStoreInstance.checkContactsAccess({ (accessGranted: Bool) in
            if accessGranted {
                self.fetchAllContacts()
            }
        })
    }
    
    func numberOfSections() -> Int {
        return contactDatas.count
    }
    
    func numberOfCells(_ sectionIndex: Int) -> Int {
        return contactDatas[sectionIndex].count
    }

    subscript(_ sectionIndex: Int) -> [Contact] {
        return contactDatas[sectionIndex]
    }

    subscript(_ sectionIndex: Int, rowIndex: Int) -> Contact {
        return contactDatas[sectionIndex][rowIndex]
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
                self.appendTitles(value.familyName)
            })
            
            self.createContactDatas(contacts)
            
            NotificationCenter.default.post(name: Notification.Name.contactDataManager, object: self)
        })
    }
    
    func createContactDatas(_ contacts: [CNContact]) {
        self.sortTitles()
        self.titles.forEach({ (title: String) in
            self.contactDatas.append(createValuesInContactDatas(title, contacts))
        })
    }
    
    func createValuesInContactDatas(_ comparedTitle: String, _ contacts: [CNContact]) -> [Contact] {
        var values: [Contact] = [Contact]()

        contacts.forEach({ (contact: CNContact) in
            if seperateWords(contact.familyName).hasPrefix(comparedTitle) {
                values.append(createContact(contact))
            }
        })

        return values
    }
}

// MARK: - Functions of contacts
private extension ContactDataManager {
    func createContact(_ value: CNContact) -> Contact {
        let lastName = value.familyName
        let firstName = value.givenName
        let imageData: Data? = value.thumbnailImageData
        let phoneNumber = value.phoneNumbers.first?.value.stringValue ?? ""
        let email = value.emailAddresses.first?.value as String? ?? ""
        return Contact(lastName, firstName, phoneNumber, email, imageData)
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
        
        guard isKorean(words) else { return word }
        
        let wordScalas = word.unicodeScalars
        let wordUnicode = Int(wordScalas[wordScalas.startIndex].value)
        let initialScalas = Words.startedKoreanWord.unicodeScalars
        let initialUnicode = Int(initialScalas[initialScalas.startIndex].value)
        let index = ((wordUnicode - initialUnicode) / 28) / 21
        return Words.initialConsonants[index]
    }
    
    func sortTitles() {
        self.titles = self.titles.filterDuplicatedElements().sorted()
    }
    
    struct Words {
        static let initialConsonants = ["ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]
        static let patternOfKorean = "[가-힣]"
        static let startedKoreanWord = "가"
    }
}
