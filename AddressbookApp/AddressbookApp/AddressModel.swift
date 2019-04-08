//
//  AddressModel.swift
//  AddressbookApp
//
//  Created by 윤동민 on 01/04/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import Foundation
import Contacts

class AddressModel {
    private var addressByInitial: Dictionary<String, [CNContact]> = [:]
    private var sortedKeys: [String] = []
    
    func set(information: [CNContact]) {
        setDictionary(of: information)
        sortedKeys = addressByInitial.keys.sorted()
        NotificationCenter.default.post(name: .setAddress, object: nil)
    }
    
    private func setDictionary(of information: [CNContact]) {
        for each in information {
            let key = Extractor.extractInitial(from: each.familyName)
            if addressByInitial[key] == nil { addressByInitial.updateValue([each], forKey: key) }
            else { addressByInitial[key]?.append(each) }
        }
    }
    
    func countSection() -> Int {
        return addressByInitial.count
    }
    
    func countRow(at section: Int) -> Int {
        guard let group = addressByInitial[sortedKeys[section]] else { return 0 }
        return group.count
    }
    
    func getGroupKey(at section: Int) -> String {
        if sortedKeys.count == 0 { return "" }
        return sortedKeys[section]
    }
    
    func access(section: Int, row: Int, form: (CNContact) -> Void) {
        guard let group = addressByInitial[sortedKeys[section]] else { return }
        form(group[row])
    }
    
    func getIndexBy(_ title: String) -> Int {
        for index in 0..<sortedKeys.count {
            if title == sortedKeys[index] { return index }
        }
        return sortedKeys.count
    }
    
    func filterBy(_ text: String) -> [AddressDTO] {
        var filteredAddresses: [AddressDTO] = []
        guard text.count != 0 else { return [] }
        let searchBarTextTypes = eachTextType(text)
        let allAddresses = getAllAddresses()
        
        for address in allAddresses {
            guard let fullName = CNContactFormatter.string(from: address, style: .fullName) else { return [] }
            var index = 0
            for unicode in fullName.unicodeScalars {
                switch searchBarTextTypes[index] {
                case .hangulInitial:
                    let textIndex = text.index(text.startIndex, offsetBy: index)
                    if String(text[textIndex]) == Extractor.extractInitial(from: unicode) { index += 1 }
                    else { index = 0 }
                default:
                    let textIndex = text.index(text.startIndex, offsetBy: index)
                    if String(unicode) == String(text[textIndex]) { index += 1 }
                    else { index = 0 }
                }
                if index == text.count {
                    filteredAddresses.append(AddressDTO(givenName: address.givenName,
                                                        familyName: address.familyName,
                                                        email: address.emailAddresses,
                                                        phoneNumbers: address.phoneNumbers,
                                                        imageData: address.imageData))
                    break
                }
            }
        }
        return filteredAddresses
    }
    
    private func getAllAddresses() -> [CNContact] {
        var addresses: [CNContact] = []
        for key in sortedKeys {
            guard let information = addressByInitial[key] else { return [] }
            for each in information { addresses.append(each) }
        }
        return addresses
    }
    
    private func eachTextType(_ text: String) -> [TextType] {
        var textTypes: [TextType] = []
        for unicode in text.unicodeScalars {
            if unicode.value >= 44032 && unicode.value <= 55203 { textTypes.append(.completeHangul) }
            else if unicode.value >= 97 && unicode.value <= 122 { textTypes.append(.english) }
            else { textTypes.append(.hangulInitial) }
        }
        return textTypes
    }
}
