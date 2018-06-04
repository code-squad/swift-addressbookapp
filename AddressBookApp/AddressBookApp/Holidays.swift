//
//  HolidayData.swift
//  AddressBookApp
//
//  Created by YOUTH2 on 2018. 6. 1..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

struct HolidayData: Codable {
    fileprivate var date: String
    fileprivate var subtitle: String
}

class Holidays {
    var holidays: [HolidayData]

    init(holidays: Codable) {
        self.holidays = holidays as! [HolidayData]
    }

    func row(at: Int) -> HolidayData {
        return self.holidays[at]
    }

    func date(at: Int) -> String {
        return self.holidays[at].date
    }

    func subtitle(at: Int) -> String {
        return self.holidays[at].subtitle
    }

    func count() -> Int {
        return self.holidays.count
    }
}
