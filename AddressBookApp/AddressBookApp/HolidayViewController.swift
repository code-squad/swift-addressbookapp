//
//  HolidayViewController.swift
//  AddressBookApp
//
//  Created by TaeHyeonLee on 2018. 3. 22..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import UIKit

class HolidayViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    private var holidays: Holidays! {
        didSet {
            self.tableView.dataSource = self
            self.tableView.layoutSubviews()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.holidays = Holidays(jsonFile: Keyword.fileName.value)
        }
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return holidays.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Keyword.cellName.value, for: indexPath)
        cell.textLabel?.text = holidays[indexPath.row].date
        cell.detailTextLabel?.text = holidays[indexPath.row].subtitle
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
