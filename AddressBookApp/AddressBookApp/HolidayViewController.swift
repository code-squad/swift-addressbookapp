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
        guard let elements = convertDictionary(from: jsonString.data) else { return }
        holidays.push(from: elements)
        // Do any additional setup after loading the view.
    }
    
    private func convertDictionary(from json: String) -> [[String: String]]? {
        guard let jsonData = json.data(using: .utf8) else { return nil }
        do {
            let result = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: String]]
            return result
        } catch {
            return nil
        }
    }
}

extension HolidayViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return holidays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let holiday = holidays[indexPath.row]
        cell.textLabel?.text = holiday[holidays.keyDate]
        cell.detailTextLabel?.text = holiday[holidays.keySubtitle]
        return cell
    }
}
