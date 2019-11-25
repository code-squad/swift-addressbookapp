/*
    Copyright (C) 2017 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    Model class used to represent a CNContact object.
*/

import UIKit
import Contacts

class MGCContact {
    // MARK: - Properties

    var lastName: String
    var firstName: String
    var phoneNumber: String?
    var email: String?
    var profilePictureData: Data?

    
    // MARK: - Initialization
    
    init(contact: CNContact) {
        self.lastName = contact.familyName
        self.firstName = contact.givenName
        
        if let phoneNumberValue = contact.phoneNumbers.first?.value {
            let phoneNumberText = phoneNumberValue.stringValue
            self.phoneNumber = phoneNumberText
        }
        
        if let emailValue = contact.emailAddresses.first?.value {
            let emailText = emailValue as String
            self.email = emailText
        }
        
        if let imageData = contact.thumbnailImageData {
            self.profilePictureData = imageData
        }
    }
}
