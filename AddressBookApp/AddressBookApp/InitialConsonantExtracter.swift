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
    private let koreanConsonantRange: ClosedRange<UInt32> = 12593...12622
    
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
            guard let extractedConsonant = Unicode.Scalar(consonantIndex + 0x1100)?.description else { return nil }
            return enteredConsonant(of: extractedConsonant)
        }
        
        if koreanConsonantRange.contains(value) {
            return Unicode.Scalar(value)?.description
        }
        
        return "#"
    }
    
    func initialConsonants(of string: String) -> String {
        guard !string.isEmpty else { return string }
        let koreanRange: ClosedRange<UInt32> = 0xac00...0xd7a3
        var changedString = String()
        for letter in string {
            guard let scalar = Unicode.Scalar(String(letter)),
                koreanRange.contains(scalar.value) else {
                    changedString.append(letter)
                    continue
            }
            let consonantIndex = (scalar.value - 0xac00) / 28 / 21
            guard let consonant = Unicode.Scalar(consonantIndex + 0x1100) else {
                changedString.append(letter)
                continue
            }
            let singleConsonant = enteredConsonant(of: consonant.description)
            changedString.append(singleConsonant)
        }
        return changedString
    }
    
    private func enteredConsonant(of string: String) -> String {
        guard string.count == 1 else { return string }
        let mapper: [UInt32: UInt32] = [4352: 12593,   //ㄱ
                                        4354: 12596,   //ㄴ
                                        4355: 12599,   //ㄷ
                                        4357: 12601,   //ㄹ
                                        4358: 12609,   //ㅁ
                                        4359: 12610,   //ㅂ
                                        4361: 12613,   //ㅅ
                                        4363: 12615,   //ㅇ
                                        4364: 12616,   //ㅈ
                                        4366: 12618,   //ㅊ
                                        4367: 12619,   //ㅋ
                                        4368: 12620,   //ㅌ
                                        4369: 12621,   //ㅍ
                                        4370: 12622,]  //ㅎ
        guard let scalar = Unicode.Scalar(string),
            let enteredConsonantScalar = mapper[scalar.value] else { return string }
        return Unicode.Scalar(enteredConsonantScalar)?.description ?? string
    }
}
