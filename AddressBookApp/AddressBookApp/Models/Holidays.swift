//
//  Holidays.swift
//  AddressBookApp
//
//  Created by TaeHyeonLee on 2018. 3. 23..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation

typealias JSONData = [[String: String]]

class Holidays: Codable {
    enum Key {
        case date
        case subtitle
        case image

        var value: String {
            switch self {
            case .date: return "date"
            case .subtitle: return "subtitle"
            case .image: return "image"
            }
        }
    }

    private var holidays = [Holiday]()

    func setJSONData(with fileName: String) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let data = self?.getData(from: fileName) else { return }
            guard let jsonData = self?.getJSONData(with: data) else { return }
            self?.setHolidays(jsonData: jsonData)
            NotificationCenter.default.post(name: .holidays, object: self)
        }
    }

    private func getData(from jsonFile: String) -> Data? {
        let path = Bundle.main.path(forResource: jsonFile, ofType: "json")
        let url = URL(fileURLWithPath: path!)
        return try? Data(contentsOf: url)
    }

    private func getJSONData(with data: Data) -> JSONData? {
        return try! JSONSerialization.jsonObject(with: data, options: []) as! JSONData
    }

    private func setHolidays(jsonData: JSONData?) {
        guard let jsonData = jsonData else { return }
        jsonData.forEach {
            self.holidays.append(Holiday(date: $0[Key.date.value] ?? "",
                                         subtitle: $0[Key.subtitle.value] ?? "",
                                         image: $0[Key.image.value] ?? ""))
        }
    }

    var count: Int {
        return holidays.count
    }

    subscript(index: Int) -> Holiday {
        return holidays[index]
    }

}
