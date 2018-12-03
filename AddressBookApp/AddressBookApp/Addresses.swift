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
 6. 필터링 : Consonant 이용해서 영어보다 한글이 먼저 오도록 필터링 합니다.
 7. [AddressGroup] 형태로 가공합니다.
 8. tableView.reloadData()
 */

class Addresses {
    struct AddressGroup {
        var sectionName: String
        var sectionObjects: [Address]
    }
    
    private var group = [AddressGroup]()
    
    init() {
        MGCContactStore.sharedInstance.fetchContacts { (contacts) in
            let addresses = self.extractContacts(from: contacts)
            let groupBySection = self.appendGroupBySection(from: addresses)
            let tempGroup = self.configureAddressGroup(from: groupBySection)
            self.appendAddresses(from: tempGroup)
            let key = Notification.Name(Key.reloadData)
            NotificationCenter.default.post(name: key, object: nil)
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
        guard let value = UnicodeScalar(String(text))?.value else { return nil }
        let consonant = UnicodeOfUInt32(with: value).extractConsonant()
        return consonant
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
        for consonant in Consonant.allCases {
            let key = consonant.description
            guard let value = addresses[key] else { continue }
            self.group.append(AddressGroup(sectionName: key, sectionObjects: value))
        }
    }
}

// for Controller
extension Addresses {
    var count: Int {
        return group.count
    }
    
    func sectionName(at index: Int) -> String {
        return group[index].sectionName
    }
    
    func countInSection(at index: Int) -> Int {
        return group[index].sectionObjects.count
    }
    
    func addressInSection(with indexPath: IndexPath) -> Address {
        return group[indexPath.section].sectionObjects[indexPath.row]
    }
}
