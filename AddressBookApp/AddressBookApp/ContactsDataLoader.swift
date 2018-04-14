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
    
    func accessToContacts() {
        let store = MGCContactStore()
        var contacts = [MGCContact]()
        
        store.checkContactsAccess({
            granted in
            // 주소록 접근 권한 허용시
            if granted {
                store.fetchContacts({
                    contact in
                    for info in contacts {
                    
                    }
                    
                })
            }
            // 접근 권한 비허용 시
            else {
                
            }
            
        })
        
        
    }
}
