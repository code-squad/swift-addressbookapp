//
//  HolidayViewController.swift
//  AddressBookApp
//
//  Created by YOUTH2 on 2018. 5. 31..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit

class HolidayViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var holidays: Holidays!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        let parser = HolidayDataParser()
        guard let holidayData = parser.makeHolidayData(from: parser.extractData()) else { return }
        self.holidays = Holidays(holidays: holidayData)
    }

}

extension HolidayViewController: UITableViewDataSource {

    //섹션에 몇 개의 데이터(row)가 있는지
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.holidays.count()
    }

    // 데이터를 표시할 템플릿, 셀
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        myCell.textLabel?.text = self.holidays.date(at: indexPath.row)
        myCell.detailTextLabel?.text = self.holidays.subtitle(at: indexPath.row)
        return myCell
    }

}
