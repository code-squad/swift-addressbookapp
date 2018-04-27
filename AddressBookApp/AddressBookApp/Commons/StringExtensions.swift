//
//  StringExtensions.swift
//  AddressBookApp
//
//  Created by yuaming on 27/04/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

extension String {
    func matchPatterns(_ pattern: String) -> Bool {
        var regex: NSRegularExpression = NSRegularExpression()
        
        do {
            regex = try NSRegularExpression(pattern: pattern)
        } catch let e {
            NSLog(e.localizedDescription)
        }
        
        return regex.matches(in: self, range: NSRange(self.startIndex..., in: self)).count > 0
    }
}
