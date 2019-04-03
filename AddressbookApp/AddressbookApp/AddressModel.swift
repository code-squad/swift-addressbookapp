//
//  AddressModel.swift
//  AddressbookApp
//
//  Created by 윤동민 on 01/04/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import Foundation
import Contacts

struct AddressGroup {
    let key: String
    var addresses: [CNContact]
    
    init(key: String, element: CNContact) {
        self.key = key
        addresses = [element]
    }
}

class AddressModel {
    private var addressGroups: [AddressGroup] = []
    
    func set(information: [CNContact]) {
        seperateGroup(of: information)
        NotificationCenter.default.post(name: .setAddress, object: nil)
    }
    
    private func seperateGroup(of information: [CNContact]) {
        let informationCount = information.count
        guard informationCount != 0 else { return }
        var prefix = Extractor.extractInitial(from: information[0].familyName)
        addressGroups.append(AddressGroup(key: prefix, element: information[0]))
        
        guard informationCount != 1 else { return }
        for index in 1..<informationCount {
            let currentKey = Extractor.extractInitial(from: information[index].familyName)
            if prefix == currentKey {
                addressGroups[addressGroups.count-1].addresses.append(information[index])
            } else {
                addressGroups.append(AddressGroup(key: currentKey, element: information[index]))
            }
            prefix = currentKey
        }
    }
    
    func countSection() -> Int {
        return addressGroups.count
    }
    
    func countRow(at section: Int) -> Int {
        if addressGroups.count == 0 { return 0 }
        return addressGroups[section].addresses.count
    }
    
    func getGroupKey(at section: Int) -> String {
        if addressGroups.count == 0 { return "" }
        return addressGroups[section].key
    }
    
    func access(section: Int, row: Int, form: (CNContact) -> Void) {
        form(addressGroups[section].addresses[row])
    }
}
