/*
    Copyright (C) 2017 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    Structure used to represent segues to be performed after selecting a
    			feature. Defines main to take the user from the main screen of
    			a tab to a final screen that displays the expected results associated 
    			with the selected feature.
                Defines related to take the user from the main screen of a tab
    			to an intermediate screen that allows you to select
                containers, groups, or contacts, then to the final screen that 
    			displays the expected results associated with the selected feature.
                Main properties starting with "perform" indicate that
    			implementing its associated feature will involve navigating between
                three screens: the main screen of a tab, intermediate screen, and 
    			final screen that displays the feature's expected results.
*/

import UIKit

struct MGCSegue {
    // MARK: - Properties
    
    /// First segue executed after selecting a feature.
    var main: String
    
    /// Second segue executed from an intermediate screen to the final screen.
    var related: String?
    
    
    // MARK: - Initialization
    
    init(main: String, related: String? = nil) {
        self.main = main
        self.related = related
    }
}
