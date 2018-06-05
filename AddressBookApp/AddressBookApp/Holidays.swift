//
//  HolidayData.swift
//  AddressBookApp
//
//  Created by YOUTH2 on 2018. 6. 1..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

struct HolidayData: Codable {
    var date: String
    var subtitle: String
    var image: String?
}

class Holidays {
    private var holidays: [HolidayData]

    init(holidays: Codable) {
        self.holidays = holidays as! [HolidayData]
    }

    func data(at: Int) -> HolidayData {
        return self.holidays[at]
    }
    
    func count() -> Int {
        return self.holidays.count
    }
}
