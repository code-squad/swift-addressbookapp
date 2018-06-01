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

    override func viewDidLoad() {
        super.viewDidLoad()

//        tableView.dataSource = self
//        tableView.delegate = self
        let parser = HolidayDataParser()
        parser.makeJSON(of: parser.extractData()!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}

//extension HolidayViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//
//
//}
//
//extension HolidayViewController {
//
//}
