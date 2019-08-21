//
//  ViewController.swift
//  AddressBookApp
//
//  Created by joon-ho kil on 8/20/19.
//  Copyright © 2019 길준호. All rights reserved.
//

import UIKit
import Contacts

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllContacts()
    }
    
    /// Fetches all contacts, then updates all tabs accordingly.
    fileprivate func fetchAllContacts() {
        MGCContactStore.sharedInstance.fetchContacts(({(contacts: [CNContact]) in
            dump(contacts)
        
        }))
    }
}

