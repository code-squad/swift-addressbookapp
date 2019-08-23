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
    var initialitys = [String:[ContactDTO]]()
    
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
    
    mutating func makeInitialitys() {
        for contactDTO in contactDTOs {
            var initiality = ""
            if let familyName = contactDTO.getFamilyName(), familyName.count > 0  {
                initiality = getInitiality(familyName: familyName)
            }
            
            if initialitys[initiality] == nil {
                initialitys[initiality] = [contactDTO]
                continue
            }
            
            initialitys[initiality]!.append(contactDTO)
        }
        
        initialitys = [String:[ContactDTO]](uniqueKeysWithValues: initialitys.sorted(by: { $0.0 < $1.0 }))
    }
    
    func getSessionCount() -> Int {
        return initialitys.count
    }
    
    func getSessionHeader(index: Int) -> String {
        return Array(initialitys.keys)[index]
    }
    
    func getCellCount(index: Int) -> Int {
        let sessionIndexKey = Array(initialitys.keys)[index]
        return initialitys[sessionIndexKey]?.count ?? 0
    }
    
    func getContactDTO(sessionIndex: Int, cellIndex: Int) -> ContactDTO {
        let sessionIndexKey = Array(initialitys.keys)[sessionIndex]
        return (initialitys[sessionIndexKey]?[cellIndex])!
    }
    
    private func getInitiality(familyName: String) -> String {
        let str:NSString = NSString(string: familyName)
        let oneChar:UniChar = str.character(at: 0)
        var initiality:NSString = ""
        
        if (oneChar >= 0xAC00 && oneChar <= 0xD7A3){
            var firstCodeValue = ((oneChar - 0xAC00)/28)/21
            firstCodeValue += 0x1100;
            initiality = initiality.appending( NSString(format:"%C", firstCodeValue) as String ) as NSString
        }
        
        return String(initiality)
    }
}
