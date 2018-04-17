//
//  Holiday.swift
//  AddressBookApp
//
//  Created by yuaming on 17/04/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

struct Holiday: Codable {
    private(set) var date: String
    private(set) var subtitle: String
}

extension Holiday {
    enum Keys {
        case date
        case subtitle
        
        var name: String {
            switch self {
            case .date: return "date"
            case .subtitle: return "subtitle"
            }
        }
    }
}

