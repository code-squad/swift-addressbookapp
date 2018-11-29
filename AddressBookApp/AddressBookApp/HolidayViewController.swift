//
//  HolidayViewController.swift
//  AddressBookApp
//
//  Created by oingbong on 29/11/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class HolidayViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var holidays = Holidays()
    private var jsonString = JsonString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        holidays.convertAndPush(from: jsonString.data)
    }
}

extension HolidayViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return holidays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HolidayTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "holidayTableViewCell", for: indexPath) as! HolidayTableViewCell
        let holiday = holidays[indexPath.row]
        cell.dateLabel.text = holiday.date
        cell.subtitleLabel.text = holiday.subtitle
        return cell
    }
}
