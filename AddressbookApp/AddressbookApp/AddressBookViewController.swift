//
//  TableViewController.swift
//  AddressbookApp
//
//  Created by 윤동민 on 01/04/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import UIKit

class AddressBookViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        MGCContactStore.sharedInstance.checkContactsAccess { isAccess in
            if isAccess { print("접속에 성공했습니다.") }
            else { print("접속에 실패하였습니다.") }
        }
        
        MGCContactStore.sharedInstance.fetchContacts { contacts in
            
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as! AddressTableViewCell
        cell.profileImageView.image = UIImage(named: "addressbook-default-profile")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
