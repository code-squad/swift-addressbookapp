//
//  Contact.swift
//  AddressBookApp
//
//  Created by yuaming on 24/04/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

struct Contact {
    private(set) var lastName: String
    private(set) var firstName: String
    private(set) var phoneNumber: String
    private(set) var email: String
    private(set) var imageData: Data?
    
    init(_ lastName: String = "", _ firstName: String = "", _ phoneNumber: String = "", _ email: String = "", _ imageData: Data? = nil) {
        self.lastName = lastName
        self.firstName = firstName
        self.phoneNumber = phoneNumber
        self.email = email
        self.imageData = imageData
    }
}
