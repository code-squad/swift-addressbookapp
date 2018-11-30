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
            }
            controller.tableView.reloadData()
        }
    }
    
    func append(with address: Address) {
        self.addresses.append(address)
    }
    
    subscript(index: Int) -> Address {
        return addresses[index]
    }
}
