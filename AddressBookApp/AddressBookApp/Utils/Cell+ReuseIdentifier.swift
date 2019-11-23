//
//  Cell+ReuseIdentifier.swift
//  AddressBookApp
//
//  Created by CHOMINJI on 2019/11/23.
//  Copyright © 2019 cmindy. All rights reserved.
//

import UIKit

extension UITableViewCell {
    static var reuseID: String {
        return String(describing: self)
    }
}
