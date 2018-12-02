//
//  UInt32+uppercase.swift
//  AddressBookApp
//
//  Created by oingbong on 02/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

extension UInt32 {
    var uppercase: UInt32 {
        switch self {
        case 97...122: return self - 32
        default: return self
        }
    }
}
