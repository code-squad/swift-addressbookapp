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

    // 영어, 한글, 기타 문자인지 판단
    func checkConsonantOf(address: AddressData) -> UInt32 {
        let name = address.name

        if isEnglish(text: name) {
            guard let code = matchEng(text: name) else { return AddressMatrix.ALL_CODE_RANGE.last! }
            return code
        } else if isKorean(text: name) {
            guard let code = matchKor(text: name) else { return AddressMatrix.ALL_CODE_RANGE.last! }
            return code
        } else {
            // 특수문자의 경우 code range의 가장 마지막 숫자를 리턴
            return AddressMatrix.ALL_CODE_RANGE.last!
        }
    }

    func isKorean(text: String) -> Bool {
        guard let text = text.first else { return false }
        guard let value = UnicodeScalar(String(text))?.value else { return false }
        return AddressMatrix.KOREAN_LETTER_RANGE ~= value
    }

    func isEnglish(text: String) -> Bool {
        guard let letter = text.uppercased().first else { return false }
        guard let value = UnicodeScalar(String(letter))?.value else { return false }
        return AddressMatrix.ENGLISH_LETTER_RANGE ~= value
    }

    // 초성의 KOR INITIAL CONSONANT CODES 리턴
    private func matchKor(text: String) -> UInt32? {
        guard let text = text.first else { return nil }
        let val = UnicodeScalar(String(text))?.value
        guard let value = val else { return nil }
        let firstConsonant = (value - 0xac00) / 28 / 21
        return firstConsonant
    }

    // 초성의 ENG INITIAL CONSONANT CODES 리턴
    private func matchEng(text: String) -> UInt32? {
        guard let first = text.uppercased().first else { return nil }
        guard let scalarValue = UnicodeScalar(String(first))?.value else { return nil }
        let converted = scalarValue - 46
        return converted
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
