//
//  HolidayViewController.swift
//  AddressBookApp
//
//  Created by YOUTH2 on 2018. 5. 31..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit

class HolidayViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var holidays: Holidays!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 80.0

        let parser = HolidayDataParser()
        guard let holidayData = parser.makeHolidayData(from: parser.extractData()) else { return }
        self.holidays = Holidays(holidays: holidayData)
    }

}

extension HolidayViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}

extension HolidayViewController: UITableViewDataSource {

    //섹션에 몇 개의 데이터(row)가 있는지
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.holidays.count()
    }

    // 데이터를 표시할 템플릿, 셀
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! HolidayTableViewCell
        myCell.status = self.holidays.data(at: indexPath.row)
        return myCell
    }
}
