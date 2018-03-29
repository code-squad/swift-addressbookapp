//
//  ContactsInformation.swift
//  AddressBookApp
//
//  Created by TaeHyeonLee on 2018. 3. 29..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation
import Contacts

class ContactsInformation {
    private var contacts = [[CNContact]]()
    private(set) var headers = [String]()

    // UTF-8
    private let KOREAN_START = 44032  // "가"
    private let KOREAN_END = 55199    // "힣"
    private let INITIAL_CYCLE = 588
    private let koreanInitial = [
        "ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ",
        "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"
    ]

    func set(with allContacts: [CNContact]) {
        allContacts.forEach { add(contact: $0) }
    }

    private func add(contact: CNContact) {
        let index = headerIndex(of: "\(contact.familyName)")
        if index < contacts.count {
            contacts[index].append(contact)
            contacts[index].sort(by: { (lhs, rhs) in
                lhs.givenName.localizedCaseInsensitiveCompare(rhs.givenName) == .orderedAscending
            })
        } else if index == contacts.count {
            contacts.append([contact])
        }
    }

    private func headerIndex(of name: String) -> Int {
        let initial = name.trimmingCharacters(in: [" "]).first ?? "_"
        let header = getHeader(from: String(initial))
        guard let headerIndex = headers.index(of: header) else {
            headers.append(header)
            return headers.count - 1
        }
        return headerIndex
    }

    private func getHeader(from initial: String) -> String {
        let scala = initial.unicodeScalars
        let unicode = Int(scala[scala.startIndex].value)
        let header = getHeader(of: unicode)
        return header
    }

    private func getHeader(of unicode: Int) -> String {
        if isKorean(unicode: unicode) {
            let index = unicode - KOREAN_START
            let header = koreanInitial[index / INITIAL_CYCLE]
            return header
        } else {
            return String(UnicodeScalar(unicode) ?? "_")
        }
    }

    private func isKorean(unicode: Int) -> Bool {
        return unicode >= KOREAN_START && unicode <= KOREAN_END
    }

    var numberOfSections: Int {
        return contacts.count
    }

    func header(at section: Int) -> String? {
        guard headers.count > section else { return nil }
        return String(headers[section])
    }

    func numberOfRows(in section: Int) -> Int {
        return contacts[section].count
    }

    func contact(in section: Int, at row: Int) -> CNContact {
        return contacts[section][row]
    }
}
