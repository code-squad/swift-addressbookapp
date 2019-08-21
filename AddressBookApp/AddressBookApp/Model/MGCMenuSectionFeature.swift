/*
    Copyright (C) 2017 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    Model class used to represent a feature to be performed in the app.
*/

import UIKit

class MGCMenuSectionFeature {
    // MARK: - Properties
    
    /// Indicates whether the feature is enabled in the tab.
    var enabled: Bool
    
    /// Provides the feature's title.
    var label: String
    
    /// Segue to be performed when the feature is tapped.
    var segue: MGCSegue
    
    /// Title of the next screen to be displayed after selecting this feature.
    var title: String
    
    
    // MARK: - Initialization
    
    init(enabled: Bool, label: String, segue: MGCSegue, title: String) {
        self.enabled = enabled
        self.label = label
        self.segue = segue
        self.title = title
    }
}

