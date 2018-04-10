//
//  File.swift
//  AddressBookApp
//
//  Created by Eunjin Kim on 2018. 4. 10..
//  Copyright © 2018년 Eunjin Kim. All rights reserved.
//

import Foundation

class HolidayDataLoader {
    enum Contstant: String {
        case cellIdentifier = "HolidayCell"
        case title = "date"
        case subTitle = "subtitle"
        case weatherImage = "image"
        case dataResource = "HolidayJsonData"
    }
    private var json: Array<Dictionary<String,String>> = []
    private static var holidayDataLoader = HolidayDataLoader()
    private init() {
        // json 데이터 가져오기
        guard let urlPath = Bundle.main.path(forResource: Contstant.dataResource.rawValue , ofType: "json") else {
            return
        }
        // Array 형태로 데이터 변환
        if let contents = try? String(contentsOfFile: urlPath).data(using: .utf8) ?? Data() {
            guard let jsonData = try? JSONSerialization.jsonObject(with: contents, options: []) as? Array<Dictionary<String,String>> ?? [] else {
                return
            }
            json = jsonData
        }
    }
    
    func countJsonData() -> Int {
        return json.count
    }
    
    func makeJsonData(_ index: IndexPath, _ key: Contstant) -> String? {
        guard let title = json[index.row][key.rawValue] else {
            return nil
        }
        return title
    }

    static func sharedInstance() -> HolidayDataLoader {
        return holidayDataLoader
    }
}
