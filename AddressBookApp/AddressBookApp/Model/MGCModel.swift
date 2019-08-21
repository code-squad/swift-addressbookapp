/*
    Copyright (C) 2017 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    Model class used to populate the UI and perform navigation between
    			scenes.
*/

import UIKit

class MGCModel {
    // MARK: - Properties
    
    /// Specifies the tab to be populated.
    var tab = String()
    
    /// Specifies the tab's content.
    var content = [AnyObject]()
    
    /// Determines which information to display in the tab.
    var category: String?
    
    /// Specifies the segue to be executed.
    var segue: MGCSegue?
    
    
    // MARK: - Initialization
    
    init(tab: String, content: [AnyObject] = [], category: String? = nil, segue: MGCSegue? = nil) {
        self.tab = tab
        self.content = content
        self.category = category
        self.segue = segue
    }
}
