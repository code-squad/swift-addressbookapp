//
//  UInt32+uppercase.swift
//  AddressBookApp
//
//  Created by oingbong on 02/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

struct UnicodeOfUInt32 {
    var value: UInt32
    
    init(with value: UInt32) {
        let uppercase: UInt32
        switch value {
        case 97...122: uppercase = value - 32
        default: uppercase = value
        }
        self.value = uppercase
    }
}
