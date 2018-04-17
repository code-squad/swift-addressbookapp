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
    let jsonString = """
        [{"date":"1월1일", "subtitle":"신정"},
        {"date":"2월16일", "subtitle":"구정"},
        {"date":"3월1일", "subtitle":"삼일절"},
        {"date":"5월5일", "subtitle":"어린이날"},
        {"date":"5월22일", "subtitle":"석가탄신일"},
        {"date":"6월6일", "subtitle":"현충일"},
        {"date":"8월15일", "subtitle":"광복절"},
        {"date":"9월24일", "subtitle":"추석"},
        {"date":"10월3일", "subtitle":"개천절"},
        {"date":"10월9일", "subtitle":"한글날"},
        {"date":"12월25일", "subtitle":"성탄절"}]
    """
    
    func test_changeFromStringToHolidays() {
        let jsonData = HolidayDataConverter.data(jsonString)
        let holidays = HolidayDataConverter.object(jsonData)
        XCTAssertEqual(holidays.count, 11)
    }
    
    func test_hasHolidayData() {
        let dataManager = HolidayDataManager().convert(jsonString)
        let holiday = dataManager[2]
        let comparedHoliday = Holiday(date: "3월1일", subtitle: "삼일절")
        XCTAssertEqual(comparedHoliday.date, holiday.date)
        XCTAssertEqual(comparedHoliday.subtitle, holiday.subtitle)
    }
}
