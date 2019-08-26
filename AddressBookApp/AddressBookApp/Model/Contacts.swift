//
//  contactDTOs.swift
//  AddressBookApp
//
//  Created by joon-ho kil on 8/23/19.
//  Copyright © 2019 길준호. All rights reserved.
//

import Foundation
import Contacts

extension Notification.Name {
    static let reloadAddressBook = Notification.Name("reloadAddressBook")
}

struct Contacts {
    var contacts = [Contact]()
    var classification =  [(key: String, value: [Contact])]()
    
    init() {
        return
    }
    
    init(contacts: [CNContact]) {
        self.contacts = contacts.map({ (contact) -> Contact in
            return Contact(contact: contact)
        })
        sort()
        makeInitialitys()
        notifyContactsToObservers()
    }
    
    private mutating func sort() {
        contacts.sort { (left, right) -> Bool in
            return left < right
        }
    }
    
    mutating func makeInitialitys() {
        var dictionary = [String:[Contact]]()
        let hangulSystem = YKHangul()
        
        for contact in contacts {
            var initiality = ""
            if let familyName = contact.getFamilyName(), familyName.count > 0  {
                let initials = hangulSystem.getStringConsonant(string: familyName,
                                                            consonantType: .Initial)
                initiality = String(initials.first!)
            }
            
            if dictionary[initiality] == nil {
                dictionary[initiality] = [contact]
                continue
            }
            
            dictionary[initiality]!.append(contact)
        }
        
        classification = dictionary.sorted { (left, right) -> Bool in
            return left.key < right.key
        }
    }
    
    func getSessionCount() -> Int {
        return classification.count
    }
    
    func getSessionHeader(index: Int) -> String {
        return classification[index].key
    }
    
    func getCellCount(index: Int) -> Int {
        return classification[index].value.count
    }
    
    func getContact(indexPath: IndexPath) -> Contact {
        return classification[indexPath.section].value[indexPath.row]
    }
    
    func getAllSessionHeader() -> [String]? {
        let allSessionHeader = classification.map { (arg0) -> String in
            return arg0.key
        }
        
        return allSessionHeader
    }
    
    /// 연락처가 로드된 것을 옵저버에게 알리기
    private func notifyContactsToObservers() {
        NotificationCenter.default.post(name: .reloadAddressBook, object: self)
    }
    
    mutating func searchWord(_ word: String) {
        let searchResult = contacts.filter { (contact) -> Bool in
            return contact.searchWord(word)
        }
        classification.removeAll()
        classification.append((key: "", value: searchResult))
        notifyContactsToObservers()
    }
}
