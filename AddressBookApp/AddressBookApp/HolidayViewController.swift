//
//  HolidayViewController.swift
//  AddressBookApp
//
//  Created by oingbong on 29/11/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class HolidayViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private let json = """
    [{"date":"1월1일", "subtitle":"신정"},
    {"date":"2월16일", "subtitle":"구정"},
    {"date":"3월1일", "subtitle":"삼일절"},
    {"date":"5월5일", "subtitle":"어린이날"},
    {"date":"5월22일", "subtitle":"석가탄신일"},
    {"date":"6월6일", "subtitle":"현충일"},
    {"date":"8월15일", "subtitle":"광복절"},
    {"date":"9월24일", "subtitle":"추석"},
    {"date":"10월3일", "subtitle":"개천절"},
    {"date":"10월9일", "subtitle":"한글날"},
    {"date":"12월25일", "subtitle":"성탄절"}]
    """
    private var holidays = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let elements = convertDictionary() else { return }
        appendHolidays(from: elements)
        // Do any additional setup after loading the view.
    }
    
    private func convertDictionary() -> [[String: String]]? {
        guard let jsonData = json.data(using: .utf8) else { return nil }
        do {
            let result = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: String]]
            return result
        } catch {
            return nil
        }
    }

    private func appendHolidays(from elements: [[String: String]]) {
        for element in elements {
            holidays.append(element)
        }
    }
}
