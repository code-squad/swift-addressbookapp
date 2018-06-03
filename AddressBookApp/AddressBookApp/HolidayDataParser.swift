//
//  HolidayDataParser.swift
//  AddressBookApp
//
//  Created by YOUTH2 on 2018. 6. 1..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

class HolidayDataParser {

    let decoder = JSONDecoder()

    func extractData() -> Data? {
        let path = Bundle.main.path(forResource: "Holiday", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        guard let data = try? Data(contentsOf: url) else { return nil }
        return data
    }

    func makeJSON(of data: Data) -> Any? {
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
            return json
        } else {
            return nil
        }
    }

    // Codable타입 객체를 사용하여 JSONSerialization사용 X
    func makeHolidayData(from data: Data?) -> Codable? {
        guard let datum = data else { return nil }
        guard let holidays = try? decoder.decode([HolidayData].self, from: datum) else { return nil }
        return holidays
    }

}
