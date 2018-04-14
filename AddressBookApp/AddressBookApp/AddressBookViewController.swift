//
//  AddressBookViewController.swift
//  AddressBookApp
//
//  Created by Eunjin Kim on 2018. 4. 12..
//  Copyright © 2018년 Eunjin Kim. All rights reserved.
//

import UIKit

class AddressBookViewController: UITableViewController {
    var contactsDataLoader: ContactsDataLoader?
    let customCell = "addressCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: customCell, for: indexPath) as? AddressTableViewCell else {
            return AddressTableViewCell()
        }
        if let data = contactsDataLoader?.makeContactsData(indexPath: indexPath) {
            // 가져온 정보를 cell에 출력
            cell.makeAddressCell(data: data)
        }
        return cell
    }

}
