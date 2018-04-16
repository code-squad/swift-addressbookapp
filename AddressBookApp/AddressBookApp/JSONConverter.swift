//
//  JSONConverter.swift
//  AddressBookApp
//
//  Created by yuaming on 16/04/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

struct JSONConverter {
    private(set) var jsonString: String
    
    func data() -> [[String: String]] {
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
}
