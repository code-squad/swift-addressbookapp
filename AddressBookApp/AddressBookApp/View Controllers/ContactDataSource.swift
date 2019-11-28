//
//  ContactDataSource.swift
//  AddressBookApp
//
//  Created by CHOMINJI on 2019/11/26.
//  Copyright © 2019 cmindy. All rights reserved.
//

import UIKit
import Contacts

class ContactDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Section
    
    private struct Section {
        let consonant: String
        let contacts: [Contact]
    }
    
    // MARK: - Vars
    
    private var sections: [Section] = [] {
        didSet {
            contactsDidFetched?()
        }
    }
    
    // MARK: - Closures
    
    var contactsDidFetched: (() -> Void)?
    
    // MARK: - Initializer
    
    override init() {
        super.init()
        
        var consonants = Consonant.consonants
        MGCContactStore.sharedInstance.fetchContacts { contacts in
            let contacts = contacts.map { Contact(contact: $0) }
            contacts.forEach { contact in
                if let consonant = contact.fullName?.initialConsonant() {
                    consonants[consonant]?.append(contact)
                }
            }
            self.sections = consonants.keys.sorted().map { Section(consonant: $0, contacts: consonants[$0]!) }
        }
    }
    
    // MARK: - UITableView DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddressCell.reuseID, for: indexPath) as? AddressCell else {
            return .init()
        }
        let section = sections[indexPath.section]
        let contact = section.contacts[indexPath.row]
        cell.configure(contact)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].contacts.count > 0 ? sections[section].consonant : nil
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sections.map { $0.consonant }
    }
}
