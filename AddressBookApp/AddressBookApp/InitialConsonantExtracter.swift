//
//  InitialConsonantExtracter.swift
//  AddressBookApp
//
//  Created by 조재흥 on 19. 4. 6..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

struct InitialConsonantExtracter {
    
    private let englishUpperCaseRange: ClosedRange<UInt32> = 65...90
    private let englishLowerCaseRange: ClosedRange<UInt32> = 97...122
    private let koreanRange: ClosedRange<UInt32> = 0xac00...0xd7a3
    private let koreanKonsonantRange: ClosedRange<UInt32> = 12593...12622
    
    func extract(word: String) -> String? {
        guard word.count > 0,
            let first = word.first,
            let scalar = Unicode.Scalar(String(first)) else { return nil }
        var value = scalar.value

        if englishLowerCaseRange.contains(value) {
            value += 32
        }
        
        if englishUpperCaseRange.contains(value) {
            return Unicode.Scalar(value)?.description
        }
        
        if koreanRange.contains(value) {
            let consonantIndex = (value - 0xac00) / 28 / 21
            return Unicode.Scalar(consonantIndex + 0x3131)?.description
        }
        
        if koreanKonsonantRange.contains(value) {
            return Unicode.Scalar(value)?.description
        }
        
        return "#"
    }
}
