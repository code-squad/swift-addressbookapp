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
        // HolidayDataCell로 cell을 만들어주는 부분
        guard let data = holidayData?.makeCellData(indexPath: indexPath) else {
            return HolidayTableViewCell()
        }
        
        cell.makeHolidayCell(data: data)
        return cell
    }
}
