//
//  HolidayViewController.swift
//  AddressBookApp
//
//  Created by yuaming on 16/04/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import UIKit
import Foundation

class HolidayViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var holidayDataManager: HolidayDataManager!
    private let cellIndentifier = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        
        holidayDataManager = HolidayDataManager().convert(HolidayJson.string)
    }
}

extension HolidayViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIndentifier, for: indexPath)
        cell.textLabel?.text = holidayDataManager[indexPath.row].date
        cell.detailTextLabel?.text = holidayDataManager[indexPath.row].subtitle
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return holidayDataManager.count
    }
}
