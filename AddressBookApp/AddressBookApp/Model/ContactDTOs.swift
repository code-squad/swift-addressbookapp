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
    var classification =  [(key: String, value: [ContactDTO])]()
    
    init() {
        return
    }
    
    init(contacts: [CNContact]) {
        self.contactDTOs = contacts.map({ (contact) -> ContactDTO in
            return ContactDTO(contact: contact)
        })
    }
    
    mutating func sort() {
        contactDTOs.sort { (left, right) -> Bool in
            return left < right
        }
    }
    
    mutating func makeInitialitys() {
        var dictionary = [String:[ContactDTO]]()
        
        for contactDTO in contactDTOs {
            var initiality = ""
            if let familyName = contactDTO.getFamilyName(), familyName.count > 0  {
                initiality = getInitiality(familyName: familyName)
            }
            
            if dictionary[initiality] == nil {
                dictionary[initiality] = [contactDTO]
                continue
            }
            
            dictionary[initiality]!.append(contactDTO)
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
    
    func getContactDTO(sessionIndex: Int, cellIndex: Int) -> ContactDTO {
        return classification[sessionIndex].value[cellIndex]
    }
    
    func getAllSessionHeader() -> [String]? {
        let allSessionHeader = classification.map { (arg0) -> String in
            return arg0.key
        }
        
        return allSessionHeader
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
