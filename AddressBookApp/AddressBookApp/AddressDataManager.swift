//
//  AddressDataManager.swift
//  AddressBookApp
//
//  Created by YOUTH2 on 2018. 6. 8..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation
import Contacts

class AddressDataManager {
    private var addressList: [AddressData]

    init(address: [AddressData]) {
        self.addressList = address
    }

    func data(at: Int) -> AddressData {
        return self.addressList[at]
    }

    func count() -> Int {
        return self.addressList.count
    }

    func givenName(at: Int) -> String {
        return self.addressList[at].givenName
    }

    func familyName(at: Int) -> String {
        return self.addressList[at].familyName
    }

    func email(at: Int) -> String {
        return self.addressList[at].emailAddress
    }

    func phoneNumber(at: Int) -> String {
        return self.addressList[at].phoneNumber
    }

    func profile(at: Int) -> Data? {
        return self.addressList[at].profileImage
    }

}

struct AddressData {
    fileprivate var givenName: String
    fileprivate var familyName: String
    fileprivate var phoneNumber: String
    fileprivate var emailAddress: String
    fileprivate var profileImage: Data?

    init(_ contact: CNContact) {
        self.givenName = contact.givenName ?? " "
        self.familyName = contact.familyName ?? " "
        self.phoneNumber = contact.phoneNumbers.first?.value.stringValue ?? "no phone"
        self.emailAddress = (contact.emailAddresses.first?.value) as String? ?? "no email"
        self.profileImage = contact.imageData
    }
}
