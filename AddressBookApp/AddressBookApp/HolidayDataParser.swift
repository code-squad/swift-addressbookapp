//
//  HolidayDataParser.swift
//  AddressBookApp
//
//  Created by YOUTH2 on 2018. 6. 1..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

class HolidayDataParser {

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

}
