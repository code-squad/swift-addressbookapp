//
//  Keyword.swift
//  AddressBookApp
//
//  Created by TaeHyeonLee on 2018. 3. 25..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation

enum Keyword {
    case cellName
    case fileName

    var value: String {
        switch self {
        case .cellName: return "holiday"
        case .fileName: return "Holidays"
        }
    }
}

extension Notification.Name {
    static let holidays = Notification.Name("holidays")
}
