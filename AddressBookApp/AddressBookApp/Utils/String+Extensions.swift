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
        let wordWithKCForm = String(firstWord).precomposedStringWithCompatibilityMapping
        guard let consonant = wordWithKCForm.decomposedStringWithCanonicalMapping.unicodeScalars.first else { return nil }
        return UnicodeScalar(consonant).description
    }
}
