//
//  HolidayViewController.swift
//  AddressBookApp
//
//  Created by TaeHyeonLee on 2018. 3. 22..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import UIKit

class HolidayViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self as? UITableViewDataSource
        let path = Bundle.main.path(forResource: "Holidays", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        guard let data = try? Data.init(contentsOf: url) else { return }
        guard let holidays = try? JSONDecoder().decode([[String:String]].self, from: data) else { return }
        print(holidays)

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
