//
//  ArrayExtensions.swift
//  AddressBookApp
//
//  Created by yuaming on 27/04/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    func filterDuplicatedElements() -> [Element] {
        var elements: [Element] = [Element]()
        
        for element in self {
            if !elements.contains(element) {
                elements.append(element)
            }
        }
        
        return elements
    }
}
