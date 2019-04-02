//
//  DTOCNContact.swift
//  AddressbookApp
//
//  Created by 윤동민 on 02/04/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import Foundation
import Contacts

struct AddressDTO {
    var givenName: String
    var familyName: String
    var email: [CNLabeledValue<NSString>]
    var phoneNumbers: [CNLabeledValue<CNPhoneNumber>]
    var imageData: Data?
    
    init(givenName: String,
         familyName: String,
         email: [CNLabeledValue<NSString>],
         phoneNumbers: [CNLabeledValue<CNPhoneNumber>],
         imageData: Data?) {
        self.givenName = givenName
        self.familyName = familyName
        self.email = email
        self.phoneNumbers = phoneNumbers
        self.imageData = imageData
    }
}
