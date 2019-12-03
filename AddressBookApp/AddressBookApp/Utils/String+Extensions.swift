//
//  String+Extensions.swift
//  AddressBookApp
//
//  Created by CHOMINJI on 2019/11/27.
//  Copyright © 2019 cmindy. All rights reserved.
//

import Foundation

extension String {
    func initialConsonant() -> String? {
        guard let firstWord = self.first else { return nil }
        guard let consonant = String(firstWord).decomposedStringWithCompatibilityMapping.unicodeScalars.first else { return nil }
        return UnicodeScalar(consonant).description
    }
}
