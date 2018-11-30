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
    var keyImage = "image"
    private var holidays = [Holiday]()
    
    var count: Int {
        return holidays.count
    }
    
    init(json: String) {
        guard let elements = convertDictionary(from: json) else { return }
        buildHoliday(from: elements)
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
    
    mutating private func buildHoliday(from elements: [[String: String]]) {
        for element in elements {
            guard let date = element[keyDate] else { continue }
            guard let subtitle = element[keySubtitle] else { continue }
            let image = element[keyImage]
            let holiday = Holiday(date: date, subtitle: subtitle, image: image)
            holidays.append(holiday)
        }
    }
    
    subscript(index: Int) -> Holiday {
        return holidays[index]
    }
}
