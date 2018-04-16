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
    private var jsonData: [[String: String]] = JSONConverter(jsonString: JSON.string).data()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
    }
}

extension HolidayViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewProperties.holidayTableCell, for: indexPath)
        
        if jsonData.count > 0 {
            cell.textLabel?.text = jsonData[indexPath.row]["date"]
            cell.detailTextLabel?.text = jsonData[indexPath.row]["subtitle"]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonData.count
    }
}
