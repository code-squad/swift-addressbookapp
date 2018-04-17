//
//  HolidayViewController.swift
//  AddressBookApp
//
//  Created by yuaming on 16/04/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import UIKit
import Foundation

class HolidayViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var holidayDataManager: HolidayDataManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableView.reloadData()
    }
}

private extension HolidayViewController {
    @objc func refreshTableView(notification: Notification) {
        guard let holidayDataManager = notification.object as? HolidayDataManager else {
            return
        }
            
        self.holidayDataManager = holidayDataManager
    }
    
    func setup() {
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTableView(notification:)), name: Notification.Name.holidayDataManager, object: nil)
        
        holidayDataManager = HolidayDataManager()
        holidayDataManager.convert(HolidayJson.stringAddedImages)
    }
}

extension HolidayViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HolidayTableViewCell.cellIndentifier, for: indexPath) as?  HolidayTableViewCell else {
            return UITableViewCell()
        }
        
        cell.dateLabel?.text = holidayDataManager[indexPath.row].date
        cell.subtitleLabel?.text = holidayDataManager[indexPath.row].subtitle
        cell.bindImage(holidayDataManager[indexPath.row].image)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return holidayDataManager.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HolidayTableViewCell.cellHeight
    }
}
