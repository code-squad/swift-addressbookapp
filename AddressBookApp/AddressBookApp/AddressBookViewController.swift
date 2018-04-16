//
//  AddressBookViewController.swift
//  AddressBookApp
//
//  Created by Eunjin Kim on 2018. 4. 12..
//  Copyright © 2018년 Eunjin Kim. All rights reserved.
//

import UIKit

class AddressBookViewController: UITableViewController {
    var contactsData: ContactsDataLoader?
    let customCell = "addressCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        registerObserver()
        self.tableView.rowHeight = 100
    }
    
    func registerObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateAddressTable),
                                               name: Notification.Name.DidUpdateAddressTable,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(alertAccessDenied),
                                               name: Notification.Name.DidAlertAccessDenied,
                                               object: nil)
    }
    
    @objc func updateAddressTable() {
        self.tableView.reloadData()
    }
    
    @objc func alertAccessDenied() {
        let title = "주소록 접근 실패"
        let message = "주소록 접근 권한을 설정 해주세요."
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default) {(_) in }
        alert.addAction(ok)
        self.present(alert, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let countOfContacts = contactsData?.countOfContacts() else {
            return 0
        }
        return countOfContacts
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: customCell, for: indexPath) as? AddressTableViewCell else {
            return AddressTableViewCell()
        }
        if let data = contactsData?.makeContactsData(indexPath: indexPath) {
            // 가져온 정보를 cell에 출력
            cell.makeAddressCell(data: data)
            print(data)
        }
        
        return cell
    }

}
