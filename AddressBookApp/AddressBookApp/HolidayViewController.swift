//
//  HolidayViewController.swift
//  AddressBookApp
//
//  Created by Eunjin Kim on 2018. 4. 6..
//  Copyright © 2018년 Eunjin Kim. All rights reserved.
//

import UIKit

class HolidayViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var json: Array<Dictionary<String,String>> = []
    let urlPath = "/Users/elly/Documents/ios_Level3/swift-addressbookapp/AddressBookApp/AddressBookApp/HolidayJsonData.json"
}

extension HolidayViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return json.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "HolidayCell")
        cell.textLabel?.text = json[indexPath.row]["date"]
        cell.detailTextLabel?.text = json[indexPath.row]["subtitle"]
        return cell
    }
}

extension HolidayViewController: UITableViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let contents = try? String(contentsOfFile: urlPath).data(using: .utf8) {
            self.json = try! JSONSerialization.jsonObject(with: contents!, options: []) as! Array<Dictionary<String,String>>
            print(json)
        }
        tableView.dataSource = self
        tableView.delegate = self
    }
}
