//
//  Holiday.swift
//  AddressBookApp
//
//  Created by Eunjin Kim on 2018. 4. 6..
//  Copyright © 2018년 Eunjin Kim. All rights reserved.
//

import Foundation

//[{"date":"1월1일", "subtitle":"신정"},
//Array<Dictionary<String,String>>
struct Holiday {
    var date: String
    var subtitle: String
}

struct HolidayList {
    var list: [Holiday]
}
