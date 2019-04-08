//
//  TableViewController.swift
//  AddressbookApp
//
//  Created by 윤동민 on 01/04/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import UIKit

extension NSNotification.Name {
    static let setAddress = NSNotification.Name(rawValue: "setAddress")
}

class AddressBookViewController: UITableViewController {
    private var address: AddressModel = AddressModel()
    private var filteredAddress: [AddressDTO] = []
    private let indexTitle = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "ㄱ", "ㄴ", "ㄷ", "ㄹ", "ㅁ", "ㅂ", "ㅅ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]
    @IBOutlet weak var searchBar: UISearchBar!
    private var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: .setAddress, object: nil)
        MGCContactStore.sharedInstance.fetchContacts { contacts in
            self.address.set(information: contacts)
        }
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        searchBar.placeholder = "Searching Name"
    }
    
    @objc func reloadTableView() {
        self.tableView.reloadData()
    }
}

extension AddressBookViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if isSearching == false { return address.countSection() }
        else { return 1 }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if isSearching == false { return address.countRow(at: section) }
        else { return filteredAddress.count }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "addressCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! AddressTableViewCell
        
        if isSearching == false {
            address.access(section: indexPath.section, row: indexPath.row) {
                let addreessDTO = AddressDTO(givenName: $0.givenName,
                                             familyName: $0.familyName,
                                             email: $0.emailAddresses,
                                             phoneNumbers: $0.phoneNumbers,
                                             imageData: $0.imageData)
                cell.set(addreessDTO)
            }
        } else {
            cell.set(filteredAddress[indexPath.row])
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isSearching == false { return address.getGroupKey(at: section) }
        else { return nil }
    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        if isSearching == false { return address.getIndexBy(title) }
        else { return 0 }
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if isSearching == false { return indexTitle }
        else { return nil }
    }
}

extension AddressBookViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            isSearching = false
        } else {
            filteredAddress = address.filterBy(searchText)
            isSearching = true
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}
