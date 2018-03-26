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
            DispatchQueue.main.async {
                self.tableView.dataSource = self
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(holidaysSetted(notification:)),
            name: .holidays,
            object: nil
        )
        self.holidays = Holidays()
        self.holidays.setJSONData(with: Keyword.fileName.value)
    }

    @objc private func holidaysSetted(notification: Notification) {
        guard let holidays = notification.object as? Holidays else { return }
        self.holidays = holidays
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
