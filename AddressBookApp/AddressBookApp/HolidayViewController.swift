//
//  HolidayViewController.swift
//  AddressBookApp
//
//  Created by Eunjin Kim on 2018. 4. 6..
//  Copyright © 2018년 Eunjin Kim. All rights reserved.
//

import UIKit

class HolidayViewController: UIViewController, UITableViewDelegate {
    struct Contstant {
        static let cellIdentifier = "HolidayCell"
        static let title = "date"
        static let subTitle = "subtitle"
    }
    @IBOutlet weak var tableView: UITableView!
    var json: Array<Dictionary<String,String>> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let urlPath = Bundle.main.path(forResource: "HolidayJsonData", ofType: "json") else {
            return
        }
        if let contents = try? String(contentsOfFile: urlPath).data(using: .utf8) ?? Data() {
            guard let jsonData = try? JSONSerialization.jsonObject(with: contents, options: []) as? Array<Dictionary<String,String>> ?? [] else {
                return
            }
            json = jsonData
        }
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension HolidayViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return json.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: Contstant.cellIdentifier)
        cell.textLabel?.text = json[indexPath.row][Contstant.title]
        cell.detailTextLabel?.text = json[indexPath.row][Contstant.subTitle]
        return cell
    }
}
