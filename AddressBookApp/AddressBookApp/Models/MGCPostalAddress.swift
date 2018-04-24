/*
    Copyright (C) 2017 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    Structure used to represent a CNPostalAddress object.
*/

import UIKit

struct MGCPostalAddress {
    // MARK: - Properties
    
    /// Maps to the postal address' street.
    var street = String()
    
    /// Maps to the postal address' city.
    var city = String()
    
    /// Maps to the postal address' state.
    var state = String()
    
    /// Maps to the postal address' postal code.
    var postalCode = String()
    
    /// Maps to the postal address' country.
    var country = String()
}
