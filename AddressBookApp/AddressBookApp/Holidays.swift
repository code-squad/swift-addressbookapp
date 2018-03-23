//
//  Holidays.swift
//  AddressBookApp
//
//  Created by TaeHyeonLee on 2018. 3. 23..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation

struct Holidays {
    enum Key: String {
        case date = "date"
        case subtitle = "subtitle"
    }
    private var holidays = [Holiday]()

    init(jsonData: [[String : String]]) {
        for eachData in jsonData {
            let keys = eachData.keys
            var date = ""
            var subtitle = ""
            for key in keys {
                if case Key.date.rawValue = key {
                    date = eachData[key]!
                } else {
                    subtitle = eachData[key]!
                }
            }
            holidays.append(Holiday(date: date, subtitle: subtitle))
        }
    }

    var count: Int {
        return holidays.count
    }

    subscript(index: Int) -> Holiday {
        return holidays[index]
    }
}

struct Holiday: Codable {
    let date: String
    let subtitle: String
    init(date: String, subtitle: String) {
        self.date = date
        self.subtitle = subtitle
    }
}
