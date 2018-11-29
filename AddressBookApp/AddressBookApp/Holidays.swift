//
//  Holidays.swift
//  AddressBookApp
//
//  Created by oingbong on 29/11/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

struct Holidays {
    var keyDate = "date"
    var keySubtitle = "subtitle"
    var holiday = [[String: String]]()
    
    var count: Int {
        return holiday.count
    }
    
    mutating func push(from elements: [[String: String]]) {
        for element in elements {
            holiday.append(element)
        }
    }
    
    subscript(index: Int) -> [String: String] {
        return holiday[index]
    }
}
