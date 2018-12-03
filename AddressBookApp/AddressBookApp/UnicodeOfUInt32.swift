//
//  UInt32+uppercase.swift
//  AddressBookApp
//
//  Created by oingbong on 02/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

struct UnicodeOfUInt32 {
    private let value: UInt32
    private let lastEnglishUnicode = 122
    private let forConsonant: UInt32 = 46
    
    init(with value: UInt32) {
        let uppercase: UInt32
        switch value {
        case 97...122: uppercase = value - 32
        default: uppercase = value
        }
        self.value = uppercase
    }
    
    func extractConsonant() -> Int {
        guard self.value > lastEnglishUnicode else { return Int(self.value - forConsonant) }
        let koreanUnicode = (self.value - 0xAC00) / 28 / 21
        return Int(koreanUnicode)
    }
}
