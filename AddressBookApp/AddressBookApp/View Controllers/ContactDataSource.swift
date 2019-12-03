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
    
    struct Section {
        let consonant: String
        let contacts: [Contact]
    }
    
    // MARK: - Vars
    
    private var sections: [Section] = [] {
        didSet {
            contactsDidFetched?()
        }
    }
    
    private var filteredSections: [Section] {
        return searchText.isEmpty ? sections : sections.filter { check(section: $0) }
    }
    
    var searchText: String = "" {
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
            contacts.forEach {
                let contact = Contact(contact: $0)

                if let consonant = contact.fullName?.initialConsonant() {
                    consonants[consonant]?.append(contact)
                }
            }
            self.sections = consonants.keys.sorted().map { Section(consonant: $0, contacts: consonants[$0]!) }
        }
    }
    
    // MARK: - UITableView DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredSections[section].contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddressCell.reuseID, for: indexPath) as? AddressCell else {
            return .init()
        }
        let section = filteredSections[indexPath.section]
        let contact = section.contacts[indexPath.row]
        cell.configure(contact)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return filteredSections[section].contacts.count > 0 ? filteredSections[section].consonant : nil
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return searchText.isEmpty ? filteredSections.map { $0.consonant } : nil
    }
}

// MARK: - Methods

extension ContactDataSource {
    private func check(name: String) -> Bool {
        return name.contains(searchText) || searchText.isEmpty
    }
    
    private func check(section: Section) -> Bool {
        return !section.contacts.filter { check(name: $0.fullName!) }.isEmpty
    }
}
