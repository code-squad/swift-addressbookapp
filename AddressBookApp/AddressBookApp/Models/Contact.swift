/*
    Copyright (C) 2017 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    Model class used to represent a CNContact object.
*/

import UIKit
import Contacts

class Contact {
    // MARK: - Properties

    let fullName: String?
    let phoneNumber: String?
    let email: String?
    let profilePictureData: Data?

    
    // MARK: - Initialization
    
    init(contact: CNContact) {
        self.fullName = CNContactFormatter.string(from: contact, style: .fullName)
        self.phoneNumber = contact.phoneNumbers.first?.value.stringValue
        self.email = contact.emailAddresses.first?.value as String?
        self.profilePictureData = contact.thumbnailImageData
    }
}
