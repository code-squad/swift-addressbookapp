//
//  AddressBookViewController.swift
//  AddressBookApp
//
//  Created by 조재흥 on 19. 4. 1..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

class AddressBookViewController: UITableViewController {

    //MARK: - Properties
    //MARK: IBOutlet
    
    @IBOutlet var contactTableView: UITableView!
    
    //MARK: Private
    
    private var contacts = Addresses()
    private let searchController = UISearchController(searchResultsController: nil)
    
    //MARK: - Methods
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadTableView),
                                               name: .updatedContacts,
                                               object: nil)
    }
    
    //MARK: Instance
    
    private func isFiltering() -> Bool {
        return searchController.isActive && !searchController.searchBar.isEmpty()
    }
    
    //MARK: @objc
    
    @objc private func reloadTableView(_ noti: Notification) {
        contactTableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if isFiltering() { return contacts.filterdCount() }
        return contacts[section]?.count() ?? 0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return isFiltering() ? 1 : contacts.count()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddressTableViewCell.identifier, for: indexPath)

        guard let addressCell = cell as? AddressTableViewCell else { return cell }
        
        if isFiltering(),
            let mgcContact = contacts.filteredAddress(index: indexPath.row) {
            addressCell.show(contact: mgcContact)
            return addressCell
        }
        
        guard let addressSection = contacts[indexPath.section],
            let mgcContact = addressSection[indexPath.row] else { return addressCell }
        addressCell.show(contact: mgcContact)
        return addressCell
    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return contacts.indexOfTitle(index) ?? -1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let addressSection = contacts[section], !isFiltering() else { return nil }
        return addressSection.title
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return isFiltering() ? nil : contacts.indexTitles
    }
}

extension AddressBookViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        contacts.filterContactWith(searchText: searchText)
    }
}

extension UISearchBar {
    func isEmpty() -> Bool {
        return text?.isEmpty ?? true
    }
}
