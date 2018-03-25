//
//  Holidays.swift
//  AddressBookApp
//
//  Created by TaeHyeonLee on 2018. 3. 23..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation

typealias JSONData = [[String: String]]

struct Holidays: Codable {
    enum Key {
        case date
        case subtitle

        var value: String {
            switch self {
            case .date: return "date"
            case .subtitle: return "subtitle"
            }
        }
    }

    private var holidays = [Holiday]()

    init?(jsonFile: String) {
        guard let data = getData(from: jsonFile) else { return nil }
        guard let jsonData = getJSONData(with: data) else { return nil }
        setHolidays(jsonData: jsonData)
    }

    private func getData(from jsonFile: String) -> Data? {
        let path = Bundle.main.path(forResource: jsonFile, ofType: "json")
        let url = URL(fileURLWithPath: path!)
        return try? Data(contentsOf: url)
    }

    private func getJSONData(with data: Data) -> JSONData? {
        return try! JSONSerialization.jsonObject(with: data, options: []) as! JSONData
    }

    private mutating func setHolidays(jsonData: JSONData?) {
        guard let jsonData = jsonData else { return }
        jsonData.forEach {
            self.holidays.append(Holiday(date: $0[Key.date.value] ?? "",
                                         subtitle: $0[Key.subtitle.value] ?? ""))
        }
    }

    var count: Int {
        return holidays.count
    }

    subscript(index: Int) -> Holiday {
        return holidays[index]
    }
}
