//
//  HolidayViewController.swift
//  AddressBookApp
//
//  Created by Eunjin Kim on 2018. 4. 6..
//  Copyright © 2018년 Eunjin Kim. All rights reserved.
//

import UIKit

class HolidayViewController: UIViewController, UITableViewDelegate {
    var holidayData: HolidayDataLoader?
    let customCell = "customCell"
    typealias Constant = HolidayDataLoader.Contstant
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension HolidayViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let jsonCount = holidayData?.countJsonData() else {
            return 0
        }
        return jsonCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: customCell, for: indexPath) as? HolidayTableViewCell else {
            return HolidayTableViewCell()
        }
        
        cell.dateLabel.text = holidayData?.makeJsonData(indexPath, Constant.title)
        cell.subtitleLabel.text = holidayData?.makeJsonData(indexPath, Constant.subTitle)
        cell.weatherImage.backgroundColor = UIColor.gray
        if let imageName = holidayData?.makeJsonData(indexPath, Constant.weatherImage) {
            cell.weatherImage.image = UIImage(named: imageName)
        }
        return cell
    }
}
