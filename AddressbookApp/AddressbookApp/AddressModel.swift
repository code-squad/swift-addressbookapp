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
    private var information: [CNContact] = []
    
    private var informationByFamilyName: [[CNContact]] = []
    
    func set(information: [CNContact]) {
        self.information = information
        NotificationCenter.default.post(name: .setAddress, object: nil)
    }
    
//    func set(information: [CNContact]) {
//        let rowCount = countRow(of: information)
//        print(rowCount)
//    }
//
//    func countRow(of information: [CNContact]) -> Int {
//        guard information.count != 0 else { return 0 }
//        var count = 0
//        var prefix = information.first?.familyName.first
//        for index in 1..<information.count {
//            if prefix != information[index].familyName.first { count += 1 }
//            prefix = information[index].familyName.first
//        }
//        return count
//    }
    
    func count() -> Int {
        return information.count
    }
    
    func access(at index: Int, form: (CNContact) -> Void) {
        form(information[index])
    }
}
