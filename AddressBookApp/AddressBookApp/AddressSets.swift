//
//  AddressSets.swift
//  AddressBookApp
//
//  Created by YOUTH2 on 2018. 6. 15..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

class AddressSets {
    private var sets: [UInt32 : [AddressData]] = [:]
    private var addressList = [AddressData]()

    init(_ address: [AddressData]) {
        self.addressList = address
    }

    // value가 하나도 없는 key값은 딕셔너리에서 제거
    func arrange() {
        self.sets = sets.filter{ $0.value.count > 0 }
    }

    // 연락처끼리 자기가 같은 초성을 가진 이름인지 판별하여 Bool 리턴
//    func makeDict() {
//        addressList.reduce([UInt32: [AddressData]](), { x, y in
//
//        })
//    }

    func addressDict() -> [UInt32: [AddressData]]{
        return sets.filter{ $0.value.count > 0 }
    }

    // MARK: Check Consonant

    static let KOR_CODE_RANGE: CountableClosedRange<UInt32> = 0...18
    static let KOR_INITIAL_CONSONANT_CODES: [UInt32] = Array(KOR_CODE_RANGE)
    private let ENG_START_CODE: UInt32 = 65
    private let ENG_END_CODE: UInt32 = 90
    static let ALL_LETTERS = KOR_INITIAL_CONSONANT_LETTERS + ENG_INITIAL_CONSONANT_LETTERS

    static let KOR_INITIAL_CONSONANT_LETTERS = [
        "ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"
    ]
    static let ENG_INITIAL_CONSONANT_LETTERS = [
        "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"
    ]

    func isEnglish(text: String) -> Bool {
        guard let first = text.uppercased().first else { return false }
        guard let scalarValue = UnicodeScalar(String(first))?.value else { return false }
        return ENG_START_CODE...ENG_END_CODE ~= scalarValue
    }

    func isKorean(text: String) -> Bool {
        guard let scalarValue = matchKor(text: text) else { return false }
        return AddressSets.KOR_CODE_RANGE ~= scalarValue
    }

    // 초성의 KOR INITIAL CONSONANT CODES 리턴
    func matchKor(text: String) -> UInt32? {
        guard let text = text.first else { return nil }
        let val = UnicodeScalar(String(text))?.value
        guard let value = val else { return nil }
        let firstConsonant = (value - 0xac00) / 28 / 21
        return firstConsonant
    }

    // 초성의 ENG INITIAL CONSONANT CODES 리턴
    func matchEng(text: String) -> UInt32? {
        guard let first = text.uppercased().first else { return nil }
        guard let scalarValue = UnicodeScalar(String(first))?.value else { return nil }
        let converted = scalarValue - 46
        return converted
    }

    // 영어, 한글, 기타 문자인지 판단
    func checkConsonantOf(address: AddressData) -> UInt32? {
        let name = address.name
        // 영어일때
        if isEnglish(text: name) {
            guard let code = matchEng(text: name) else { return nil }
            return code
        }
        // 한글일때
        else if isKorean(text: name) {
            guard let code = matchKor(text: name) else { return nil }
            return code
        } else {
            return nil
        }
    }

    func setConsonant(address data: AddressData) {
        self.checkConsonantOf(address: data)
    }



}

/*
private func setAsDictionary (_ beverages: [Beverage]) -> [ObjectIdentifier: [Beverage]] {
    let stockSets = beverages.reduce(into: [ObjectIdentifier: [Beverage]]()) {
        $0[ObjectIdentifier(type(of: $1)), default:[]].append($1)
    }
    return stockSets
}

 let letters = "abracadabra"
 let letterCount = letters.reduce(into: [:]) { counts, letter in
 counts[letter, default: 0] += 1
 }
 // letterCount == ["a": 5, "b": 2, "r": 2, "c": 1, "d": 1]

*/
