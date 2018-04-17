//
//  HolidayDataConverter.swift
//  AddressBookApp
//
//  Created by yuaming on 17/04/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

struct HolidayDataConverter {
    typealias JSONData = [[String: String]]
    
    static func data(_ jsonString: String) -> JSONData {
        var json: [[String: String]] = [[String: String]]()
        if let data = jsonString.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            do {
                json = try JSONSerialization.jsonObject(with: data, options: []) as! [[String: String]]
            } catch let error as NSError {
                print("Failed to converting: \(error.localizedDescription)")
            }
        }
        
        return json
    }
    
    static func object(_ jsonData: JSONData) -> [Holiday] {
        var holidays: [Holiday] = [Holiday]()
        
        guard jsonData.count > 0 else { return holidays }
        
        jsonData.forEach {
            holidays.append(Holiday(date: $0[Holiday.Keys.date.name] ?? "",
                                    subtitle: $0[Holiday.Keys.subtitle.name] ?? "",
                                    image: $0[Holiday.Keys.image.name] ?? ""
                            ))
        }
        
        return holidays
    }
}
