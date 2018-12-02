//
//  AddressList.swift
//  AddressBookApp
//
//  Created by oingbong on 30/11/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class AddressList {
    private var addresses = [Address]()
    
    enum KoreanConsonant: Int {
        case ㄱ = 0, ㄲ, ㄴ, ㄷ, ㄸ, ㄹ, ㅁ, ㅂ, ㅃ, ㅅ, ㅆ, ㅇ, ㅈ, ㅉ, ㅊ, ㅋ, ㅌ, ㅍ, ㅎ
    }
    
    var count: Int {
        return addresses.count
    }
    
    init(with controller: UITableViewController) {
        MGCContactStore.sharedInstance.fetchContacts { (contacts) in
            for contact in contacts {
                let name = contact.familyName + contact.givenName
                var tel = ""
                for phoneNumber in contact.phoneNumbers {
                    tel = phoneNumber.value.stringValue
                }
                var email = ""
                for emailAddress in contact.emailAddresses {
                    email = emailAddress.value as String
                }
                let profile = contact.imageData
                
                self.addresses.append(Address(name: name, tel: tel, email: email, profile: profile))

                guard let consonant = self.fetchConsonant(from: name) else { continue }
            }
            controller.tableView.reloadData()
        }
    }
    
    func append(with address: Address) {
        self.addresses.append(address)
    }

    private func fetchConsonant(from name: String) -> Character? {
        /*
         영어 : 앞글자 리턴 (유니코드 65 - 122)
         한글 : 앞글자 초성 리턴
         */
        guard let text = name.first else { return nil }
        guard let value = UnicodeScalar(String(text))?.value else { return nil }
        guard value > 122 else { return text }
        let index = (value - 0xAC00) / 28 / 21
        let consonant = extractConsonant(at: index)
        return consonant
    }
    
    private func extractConsonant(at index: UInt32) -> Character? {
        guard let unicodeConsonant = UnicodeScalar(0x1100 + index) else { return nil }
        let consonant = Character(unicodeConsonant)
        return consonant
    }
    
    subscript(index: Int) -> Address {
        return addresses[index]
    }
}
