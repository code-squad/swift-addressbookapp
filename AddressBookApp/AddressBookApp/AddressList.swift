//
//  AddressList.swift
//  AddressBookApp
//
//  Created by oingbong on 30/11/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit
import Contacts

/*
 1. 주소록에서 전체 데이터 가져옵니다.
 2. 주소록에서 원하는 데이터 추출합니다.
 3. [[Address]] 형태를 만들고 데이터를 저장합니다.
 1) Consonant 크기만큼 배열을 만듭니다.
 2) 한글은 첫글자 초성의 숫자, 영어는 첫글자의 숫자를 가져옵니다.
    (영어는 대문자로 변경해서 숫자를 가져옵니다.)
 4. 정해진 groupBySection 의 index 에 데이터를 저장합니다.
 5. [String: [Address]] 형태로 데이터를 가공합니다.
 6. 필터링 오름차순
 7. [AddressGroup] 형태로 가공합니다.
 8. tableView.reloadData()
 */

class AddressList {
    struct AddressGroup {
        var sectionName: String
        var sectionObjects: [Address]
    }
    
    private let lastEnglishUnicode = 122
    private let forConsonant: UInt32 = 46
    private var addressesGroup = [AddressGroup]()
    
    init(with controller: UITableViewController) {
        MGCContactStore.sharedInstance.fetchContacts { (contacts) in
            let addresses = self.extractContacts(from: contacts)
            let groupBySection = self.appendGroupBySection(from: addresses)
            let tempGroup = self.configureAddressGroup(from: groupBySection)
            self.appendAddresses(from: tempGroup)
            controller.tableView.reloadData()
        }
    }
    
    private func extractContacts(from contacts: [CNContact]) -> [Address] {
        var addresses = [Address]()
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
            addresses.append(Address(name: name, tel: tel, email: email, profile: profile))
        }
        return addresses
    }
    
    private func appendGroupBySection(from addresses: [Address]) -> [[Address]] {
        var groupBySection = configureGroupBySection()
        for address in addresses {
            guard let index = self.fetchConsonant(from: address.name) else { continue }
            groupBySection[index].append(address)
        }
        return groupBySection
    }
    
    private func configureGroupBySection() -> [[Address]] {
        var groupBySection = [[Address]]()
        for _ in 0..<Consonant.allCases.count {
            let emptyAddress = [Address]()
            groupBySection.append(emptyAddress)
        }
        return groupBySection
    }
    
    private func fetchConsonant(from name: String) -> Int? {
        /*
         영어 : 앞글자 리턴 (유니코드 65 - 122)
         한글 : 앞글자 초성 리턴
         */
        guard let text = name.first else { return nil }
        guard var value = UnicodeScalar(String(text))?.value else { return nil }
        value = value.uppercase
        guard value > lastEnglishUnicode else { return Int(value - forConsonant) }
        let index = (value - 0xAC00) / 28 / 21
        return Int(index)
    }
    
    private func configureAddressGroup(from groupBySection: [[Address]]) -> [String: [Address]] {
        var tempGroup = [String: [Address]]()
        for index in 0..<groupBySection.count {
            let addresses = groupBySection[index]
            guard let key = Consonant(rawValue: index)?.description else { continue }
            tempGroup.updateValue(addresses, forKey: key)
        }
        return tempGroup
    }
    
    private func appendAddresses(from addresses: [String: [Address]]) {
        let sortedAddresses = addresses.sorted { $0.0 < $1.0 } // 오름차순 정렬
        for (key, value) in sortedAddresses {
            self.addressesGroup.append(AddressGroup(sectionName: key, sectionObjects: value))
        }
    }
}

// for Controller
extension AddressList {
    var count: Int {
        return addressesGroup.count
    }
    
    func sectionName(at index: Int) -> String {
        return addressesGroup[index].sectionName
    }
    
    func countInSection(at index: Int) -> Int {
        return addressesGroup[index].sectionObjects.count
    }
    
    func addressInSection(sectionIndex: Int, rowIndex: Int) -> Address {
        return addressesGroup[sectionIndex].sectionObjects[rowIndex]
    }
}
