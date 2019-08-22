/*
    Copyright (C) 2017 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    Structure used to represent a CNLabeledValue object.
*/

import UIKit

struct MGCLabelValue {
    // MARK: - Properties
    
    /// Maps to the label of a contact property value.
    var label: String
    
    /// Maps to a contact property value whose type is String such as the URL address.
    var value: String
    
    /// Maps to a contact property value whose type is Data such as the profile picture.
    var imageData: Data?
    
    /// Maps to a contact property value whose type is CNPostalAddress such as the postal address.
    var address: MGCPostalAddress?
    
    
    // MARK: - Initialization
    
    init(label: String = String(), value: String = String(), imageData: Data? = nil, address: MGCPostalAddress? = nil) {
        self.label = label
        self.value = value
        self.imageData = imageData
        self.address = address
    }
    
    
    // MARK: - hasLabelValue
    
    /// - returns: true if label and value both have values and false, otherwise.
    func hasLabelValue() -> Bool {
        return (!(label.isEmpty) && !(value.isEmpty))
    }
}
