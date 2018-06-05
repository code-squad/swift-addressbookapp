//
//  ImageManager.swift
//  AddressBookApp
//
//  Created by YOUTH2 on 2018. 6. 5..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

class ImageManager {
    static func weatherImageName(of data: String?) -> String? {
        guard let weather = data else { return nil }
        switch weather {
        case "sunny": return "weather-sunny"
        case "cloudy": return "weather-cloudy"
        case "rainny": return "weather-rainny"
        case "snowy": return "weather-snowy"
        default: return nil
        }
    }
}
