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
    private var holidays: [[String: String]]? = [[String: String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        let path = Bundle.main.path(forResource: "Holidays", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        guard let data = try? Data(contentsOf: url) else { return }
        do {
            holidays = try JSONSerialization.jsonObject(with: data, options: []) as? [[String : String]]
        } catch {
            print("JSON data failed")
        }
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return holidays?.count ?? 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "holiday", for: indexPath)
        cell.textLabel?.text = holidays?[indexPath.row]["date"]
        cell.detailTextLabel?.text = holidays?[indexPath.row]["subtitle"]
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
