//
//  AddressModel.swift
//  AddressbookApp
//
//  Created by 윤동민 on 01/04/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import Foundation
import Contacts

class AddressModel {
    private var information: [CNContact] = []
    
    func set(information: [CNContact]) {
        self.information = information
        NotificationCenter.default.post(name: .setAddress, object: nil)
    }
    
    func count() -> Int {
        return information.count
    }
}
