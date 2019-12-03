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
    
    typealias ContactSection = (key: String, value: [Contact])
    
    // MARK: - Vars
    
    var searchText: String = "" {
        didSet {
            filteredSections = searchText.isEmpty ? sections : makeFilteredSection()
        }
    }
    
    private var contacts: [Contact] = [] {
        didSet {
            dataDidUpdated?()
        }
    }
    private var sections: [ContactSection] = [] {
        didSet {
            filteredSections = sections
            dataDidUpdated?()
        }
    }
    private var filteredSections: [ContactSection] = [] {
        didSet {
            dataDidUpdated?()
        }
    }
    private var searchedConsonants: [String] {
        return searchText.compactMap { String($0).initialConsonant() }
    }
    
    
    // MARK: - Closures
    
    var dataDidUpdated: (() -> Void)?
    
    // MARK: - Initializer
    
    override init() {
        super.init()
        
        var consonants = Consonant.consonants
        
        MGCContactStore.sharedInstance.fetchContacts { contacts in
            self.contacts = contacts.map { Contact(contact: $0) }
            self.contacts.forEach {
                if let consonant = $0.fullName?.initialConsonant() {
                    consonants[consonant]?.append($0)
                }
            }
            self.sections = consonants.sorted { $0.key < $1.key }
        }
    }
    
    // MARK: - UITableView DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredSections[section].value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddressCell.reuseID, for: indexPath) as? AddressCell else {
            return .init()
        }
        let section = filteredSections[indexPath.section]
        let contact = section.value[indexPath.row]
        cell.configure(contact)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return filteredSections[section].value.count > 0 ? filteredSections[section].key : nil
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return searchText.isEmpty ? filteredSections.map { $0.key } : nil
    }
}

// MARK: - Methods

extension ContactDataSource {
    private func makeFilteredSection() -> [ContactSection] {
        contacts
            .filter { check(name: $0.fullName!) }
            .reduce(into: [String: [Contact]]()) { dict, contact in
                if let consonant = contact.fullName?.initialConsonant() {
                    dict[consonant, default: []].append(contact)
                }
        }
        .sorted { $0.key < $1.key }
    }
    
    private func check(name: String?) -> Bool {
        guard let name = name?.lowercased() else { return false }
        let nameConsonants = name.compactMap { String($0).initialConsonant() }
        return name.hasPrefix(searchText) || nameConsonants.starts(with: searchedConsonants)
    }
}
