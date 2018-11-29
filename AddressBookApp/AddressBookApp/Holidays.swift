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
    
    mutating func convertAndPush(from json: String) {
        guard let elements = convertDictionary(from: json) else { return }
        push(from: elements)
    }
    
    private func convertDictionary(from json: String) -> [[String: String]]? {
        guard let jsonData = json.data(using: .utf8) else { return nil }
        do {
            let result = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: String]]
            return result
        } catch {
            return nil
        }
    }
    
    subscript(index: Int) -> [String: String] {
        return holiday[index]
    }
}
