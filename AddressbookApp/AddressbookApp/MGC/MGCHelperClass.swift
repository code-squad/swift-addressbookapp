/*
    Copyright (C) 2017 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A helper class that is used to create an alert.
*/

import UIKit

class MGCHelperClass {
    // MARK: - Create Alert Dialog
    
    /// - returns: An alert with a given title and message.
    class func alert(with title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        let action = UIAlertAction(title: NSLocalizedString(MGCAppConfiguration.Messages.ok, comment: MGCAppConfiguration.MainStoryboard.Cells.emptyString),
                                   style: .default,
                                 handler: nil)
        
        alert.addAction(action)
        return alert
    }
}
