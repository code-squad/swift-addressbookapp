//
//  AddressBookAppTests.swift
//  AddressBookAppTests
//
//  Created by yuaming on 16/04/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import XCTest
@testable import AddressBookApp

class AddressBookAppTests: XCTestCase {
    static let string: String = """
    [{"date":"1월1일", "subtitle":"신정"},
    {"date":"2월16일", "subtitle":"구정"},
    {"date":"3월1일", "subtitle":"삼일절"},
    {"date":"5월5일", "subtitle":"어린이날"}]
    """
    
    static let stringAddedImages: String = """
    [{"date":"1월1일", "subtitle":"신정", "image" : "snowy"},
    {"date":"2월16일", "subtitle":"구정", "image" : "sunny"},
    {"date":"3월1일", "subtitle":"삼일절"}]
    """
    
    func test_changeFromStringToHolidays() {
        let jsonData = HolidayDataConverter.data(HolidayJson.string)
        let holidays = HolidayDataConverter.object(jsonData)
        XCTAssertEqual(holidays.count, 11)
    }
    
    func test_hasHolidayData() {
        let dataManager = HolidayDataManager()
        dataManager.convert(HolidayJson.string)
        let holiday = dataManager[2]
        let comparedHoliday = Holiday(date: "3월1일", subtitle: "삼일절", image: "")
        XCTAssertEqual(comparedHoliday.date, holiday.date)
        XCTAssertEqual(comparedHoliday.subtitle, holiday.subtitle)
    }
    
    func test_hasHolidayDataWithImage() {
        let dataManager = HolidayDataManager()
        dataManager.convert(HolidayJson.stringAddedImages)
        let holiday = dataManager[1]
        let comparedHoliday = Holiday(date: "2월16일", subtitle: "구정", image: "sunny")
        XCTAssertEqual(comparedHoliday.date, holiday.date)
        XCTAssertEqual(comparedHoliday.subtitle, holiday.subtitle)
        XCTAssertEqual(comparedHoliday.image, holiday.image)
    }
}
