//
//  Holiday.swift
//  AddressBookApp
//
//  Created by TaeHyeonLee on 2018. 3. 25..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation

struct Holiday: Codable {
    let date: String
    let subtitle: String
    let image: String
    init(date: String, subtitle: String, image: String) {
        self.date = date
        self.subtitle = subtitle
        self.image = image
    }
}
