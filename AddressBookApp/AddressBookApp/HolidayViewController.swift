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
    private var holidays: Holidays!

    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "Holidays", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        guard let data = try? Data(contentsOf: url) else { return }
        guard let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String : String]] else { return }
        self.holidays = Holidays(jsonData: jsonData!)
        DispatchQueue.main.async {
            self.tableView.dataSource = self
            self.tableView.layoutSubviews()
        }
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return holidays.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "holiday", for: indexPath)
        cell.textLabel?.text = holidays[indexPath.row].date
        cell.detailTextLabel?.text = holidays[indexPath.row].subtitle
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
