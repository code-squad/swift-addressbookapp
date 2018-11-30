//
//  Address.swift
//  AddressBookApp
//
//  Created by oingbong on 30/11/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

class Address {
    var name: String
    var tel: String
    var email: String
    var profile: Data?
    
    init(name: String, tel: String, email: String, profile: Data?) {
        self.name = name
        self.tel = tel
        self.email = email
        self.profile = profile
    }
}
