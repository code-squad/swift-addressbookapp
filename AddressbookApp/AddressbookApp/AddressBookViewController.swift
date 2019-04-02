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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: .setAddress, object: nil)
        MGCContactStore.sharedInstance.fetchContacts { contacts in
            self.address.set(information: contacts)
        }
    }
    
    @objc func reloadTableView() {
        self.tableView.reloadData()
    }
}

extension AddressBookViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return address.count()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "addressCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! AddressTableViewCell
        
        address.access(at: indexPath.row) {
            let addressDTO = AddressDTO(givenName: $0.givenName,
                                        familyName: $0.familyName,
                                        email: $0.emailAddresses,
                                        phoneNumbers: $0.phoneNumbers,
                                        imageData: $0.imageData)
            cell.set(addressDTO)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Hi"
    }
    
}
