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
        tableView.delegate = self
        holidays.convertAndPush(from: jsonString.dataWithImage)
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
        cell.weatherImage.backgroundColor = .darkGray
        if let image = holiday.image {
            cell.weatherImage.image = UIImage(named: image)
        }
        return cell
    }
}

extension HolidayViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
