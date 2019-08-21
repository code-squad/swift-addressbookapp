/*
    Copyright (C) 2017 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A utility class that allows us to parse the resource file
    			containing the app's navigation menu.
*/

import UIKit

class MGCParsingUtilities {
    // MARK: - Types
    
    /// Keys used to parse the resource file.
    fileprivate struct ParsingKeys {
		static let enabled = "enabled"
		static let label = "label"
		static let relatedSegue = "relatedSegue"
		static let sectionContent = "sectionContent"
		static let sectionTitle = "sectionTitle"
		static let segue = "segue"
		static let tab = "tab"
		static let tabContent = "tabContent"
		static let title = "title"
    }
	
	
    // MARK: - Properties
    
    /// Name of the resource file containing the navigation menu.
    fileprivate var name: String
    
    /// Filename extension of the resource file containing the navigation menu.
    fileprivate var fileExtension: String
    
    /// - returns: An array with the resource file's content.
    fileprivate var menu: NSArray? {
        get {
				if let path = Bundle.main.path(forResource: name, ofType: fileExtension) {
                return NSArray(contentsOfFile: path)!
            }
            return nil
        }
    }

    
    // MARK: - Initialization
    
    init(name: String, fileExtension: String) {
        self.name = name
        self.fileExtension = fileExtension
    }
    
    
    // MARK: - Check Resource File Existence
    
    /**
        - returns: Boolean value that indicates whether menu contains the 
				   resource file's content. true indicates that we were able to 
				   find the specified resource file and retrieve its content. 
				   false indicates we did not find the specified resource.
    */
    func resourceWasFound() -> Bool {
        return (menu != nil)
    }
    
    
    // MARK: - Parse Resource File 
    
     /**
		- returns: Parses the app's navigation menu file to return a navigation
				   menu for a given tab.
    */
    func parse(for tab: String) -> [MGCMenuSection]? {
        var sections = [MGCMenuSection]()
        
        /* Return if menu does not exist. This is the case where we could not
			find our resource file.
        */
        guard let menu = menu else { return nil }
        
		menu.forEach({dictionary in
			if let tabContent = (dictionary as AnyObject).object(forKey: ParsingKeys.tabContent) as? [NSDictionary], ((dictionary as AnyObject).object(forKey: ParsingKeys.tab) as! String) == tab {
				
				for section in tabContent {
					
					var sectionContent = [MGCMenuSectionFeature]()
					let sectionTitle = section.object(forKey: ParsingKeys.sectionTitle) as! String
					let content = section.object(forKey: ParsingKeys.sectionContent) as! [NSDictionary]
					
					for item in content {
						
						if let relatedSegue = item.object(forKey: ParsingKeys.relatedSegue) as? String {
							
							sectionContent.append(MGCMenuSectionFeature(enabled: item.object(forKey: ParsingKeys.enabled) as! Bool,
																		  label: item.object(forKey: ParsingKeys.label) as! String,
																		  segue: MGCSegue(main: item.object(forKey: ParsingKeys.segue) as! String, related: relatedSegue),
																	      title: item.object(forKey: ParsingKeys.title) as! String))
						}
						else {
							sectionContent.append(MGCMenuSectionFeature(enabled: item.object(forKey: ParsingKeys.enabled) as! Bool,
																          label: item.object(forKey: ParsingKeys.label) as! String,
																          segue: MGCSegue(main: item.object(forKey: ParsingKeys.segue) as! String),
																		  title: item.object(forKey: ParsingKeys.title) as! String))
						}
						
					}
					
					sections.append(MGCMenuSection(title: sectionTitle, section: sectionContent))
				}
				
			}
			
		})
       return sections
    }
}
