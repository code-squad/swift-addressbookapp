/*
    Copyright (C) 2017 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    Model class used to represent a section of features in a tab.
*/

import UIKit

class MGCMenuSection {
    // MARK: - Properties
    
	/// Title of the section.
	var title: String
	
	/// Contains a section of features.
	var section: [MGCMenuSectionFeature]
	
	
	// MARK: - Initialization
	
	init(title: String, section: [MGCMenuSectionFeature]) {
		self.title = title
		self.section = section
	}
}
