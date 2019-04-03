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
}
