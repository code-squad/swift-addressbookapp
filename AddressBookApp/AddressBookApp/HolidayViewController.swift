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
        static let weatherImage = "weatherImage"
        static let customCell = "customCell"
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
        tableView.rowHeight = 80
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension HolidayViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return json.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Contstant.customCell, for: indexPath) as? HolidayTableViewCell else {
            return HolidayTableViewCell()
        }
        cell.dateLabel.text = json[indexPath.row][Contstant.title]
        cell.subtitleLabel.text = json[indexPath.row][Contstant.subTitle]
        let imageName = json[indexPath.row]["image"]
        if imageName != nil {
            cell.weatherImage.image = UIImage(named: imageName!)
        }else {
            cell.weatherImage.backgroundColor = UIColor.gray
        }
        return cell
    }
}
