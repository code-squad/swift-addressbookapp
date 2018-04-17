//
//  HolidayDataManager.swift
//  AddressBookApp
//
//  Created by yuaming on 17/04/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

class HolidayDataManager: Codable {
    private var holidays: [Holiday]
    
    init() {
        self.holidays = [Holiday]()
    }
    
    func convert(_ jsonString: String) {
        let jsonData = HolidayDataConverter.data(jsonString)
        self.holidays = HolidayDataConverter.object(jsonData)
        NotificationCenter.default.post(name: Notification.Name.holidayDataManager, object: self)
    }
    
    subscript(index: Int) -> Holiday {
        return holidays[index]
    }
    
    var count: Int {
        return holidays.count
    }
}
