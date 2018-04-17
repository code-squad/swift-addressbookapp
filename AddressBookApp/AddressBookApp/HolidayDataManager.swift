//
//  HolidayDataManager.swift
//  AddressBookApp
//
//  Created by yuaming on 17/04/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

class HolidayDataManager {
    private var holidays: [Holiday]

    init(_ holidays: [Holiday]) {
        self.holidays = holidays
    }
    
    convenience init() {
        self.init([Holiday]())
    }
    
    func convert(_ jsonString: String) -> HolidayDataManager {
        let jsonData = HolidayDataConverter.data(jsonString)
        holidays = HolidayDataConverter.object(jsonData)
        return HolidayDataManager(holidays)
    }
    
    subscript(index: Int) -> Holiday {
        return holidays[index]
    }
    
    var count: Int {
        return holidays.count
    }
}
