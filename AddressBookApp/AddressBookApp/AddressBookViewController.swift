//
//  AddressBookViewController.swift
//  AddressBookApp
//
//  Created by joon-ho kil on 8/21/19.
//  Copyright © 2019 길준호. All rights reserved.
//

import UIKit
import Contacts

class AddressBookViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet weak var wordSearchBar: UISearchBar!
    var contacts = Contacts()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(onReloadAddressBook(_:)), name: .reloadAddressBook, object: nil)
        MGCContactStore.sharedInstance.fetchContacts(({(cnContacts: [CNContact]) in
            Contacts.init(contacts: cnContacts)
        }))
        wordSearchBar.delegate = self
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return contacts.getSessionCount()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return contacts.getSessionHeader(index: section)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.getCellCount(index: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as! AddressBookTableViewCell
        
        let contact = contacts.getContact(indexPath: indexPath)
        cell.putInfo(contactDTO: contact)
        
        return cell
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return contacts.getAllSessionHeader()
    }
    
    @objc func onReloadAddressBook(_ notification:Notification) {
        contacts = notification.object as? Contacts ?? Contacts()
        self.tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            contacts.makeInitialitys()
            self.tableView.reloadData()
            return
        }
        contacts.searchWord(searchText)
    }
}
