//
//  AddressCell.swift
//  AddressBookApp
//
//  Created by Eunjin Kim on 2018. 4. 14..
//  Copyright © 2018년 Eunjin Kim. All rights reserved.
//

import Foundation
import Contacts

class ContactsDataLoader {
    
    init() {
        let store = MGCContactStore()
        var contactsData =  [ContactData]()
        
        store.checkContactsAccess({
            granted in
            // 주소록 접근 권한 허용시
            if granted {
                store.fetchContacts({
                    contacts in
                    for info in contacts {
                        let name = info.familyName + info.givenName
                        guard let phoneNumber = info.phoneNumbers.first?.value.stringValue else {
                            return
                        }
                        guard let email = info.emailAddresses.first?.value as String? else{
                            return
                        }
                        contactsData.append(ContactData.init(name: name, phoneNumber: phoneNumber, email: email))
                    }
                })
            }
            // 접근 권한 비허용 시
            else {
                // alert Notification
            }
            
        })
    }
}
