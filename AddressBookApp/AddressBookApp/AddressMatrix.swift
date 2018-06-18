//
//  AddressMatrix.swift
//  AddressBookApp
//
//  Created by YOUTH2 on 2018. 6. 15..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

class AddressMatrix { 

    // MARK: static properties

    static let KOR_CODE_RANGE: CountableClosedRange<UInt32> = 0...18
    static let ALL_CODE_RANGE: CountableClosedRange<UInt32> = 0...(AddressMatrix.ENG_END_CODE - AddressMatrix.CONVERTER + 1)
    static let CONVERTER: UInt32 = 46

    static let ALL_LETTERS = KOR_INITIAL_CONSONANT_LETTERS + ENG_INITIAL_CONSONANT_LETTERS
    static let KOR_INITIAL_CONSONANT_LETTERS = [
        "ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"
    ]
    static let ENG_INITIAL_CONSONANT_LETTERS = [
        "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "#"
    ]

    static let ENG_START_CODE: UInt32 = 65
    static let ENG_END_CODE: UInt32 = 90
    static let KOREAN_LETTER_RANGE = (UnicodeScalar("가")?.value)!...(UnicodeScalar("힣")?.value)!
    static let ENGLISH_LETTER_RANGE = (UnicodeScalar("A")?.value)!...(UnicodeScalar("Z")?.value)!

    // MARK: class properties and initializer

    private var addressList = [AddressData]()
    private var matrix: [UInt32 : [AddressData]] = [:]
    private var consonants = [String]()

    convenience init() {
        self.init([])
    }

    init(_ address: [AddressData]) {
        self.addressList = address.sorted()
        self.matrix = addressList.reduce(into: [UInt32 : [AddressData]]()) {
            $0[checkConsonantOf(address: $1), default:[]].append($1)
        }
    }

    // MARK: Check Consonant

    func checkConsonantOf(address: AddressData) -> UInt32 {
        let name = address.name
        guard let letter = name.uppercased().first else { return AddressMatrix.ALL_CODE_RANGE.last! }
        guard let value = UnicodeScalar(String(letter))?.value else { return AddressMatrix.ALL_CODE_RANGE.last! }

        if AddressMatrix.KOREAN_LETTER_RANGE ~= value {
            return ((value - 0xac00) / 28 / 21)
        } else if AddressMatrix.ENGLISH_LETTER_RANGE ~= value {
            return (value - AddressMatrix.CONVERTER)
        } else {
            return AddressMatrix.ALL_CODE_RANGE.last!
        }
    }

    // MARK: Information for Dictionary

    func countOfConsonant() -> Int {
        return self.keys().count
    }

    func consonantString(at section: Int) -> String {
        return self.consonants[section]
    }

    func keys() -> [String] {
        consonants = self.matrix.keys.sorted().map{ codeToLetter(code: Int($0)) }
        return consonants
    }

    func count(of section: Int) -> Int {
        let code = letterToCode(letter: consonants[section])
        let count = self.matrix[code]?.count ?? 0
        return count
    }

    func data(of section: Int, at row: Int) -> AddressData {
        let code = letterToCode(letter: consonants[section])
        let address = self.matrix[code]![row]
        return address
    }

    private func codeToLetter(code: Int) -> String {
        return AddressMatrix.ALL_LETTERS[code]
    }

    private func letterToCode(letter: String) -> UInt32 {
        let index = consonants.index(of: letter) ?? 0
        let keys = self.matrix.keys.sorted()
        let section = keys[index]
        return section
    }

}
