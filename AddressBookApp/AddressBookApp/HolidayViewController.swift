//
//  HolidayViewController.swift
//  AddressBookApp
//
//  Created by Eunjin Kim on 2018. 4. 6..
//  Copyright © 2018년 Eunjin Kim. All rights reserved.
//

import UIKit

class HolidayViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlPath = "/Users/elly/Documents/ios_Level3/swift-addressbookapp/AddressBookApp/AddressBookApp/HolidayJsonData.json"
        if let contents = try? String(contentsOfFile: urlPath) {
            print(contents)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
