//
//  AddressBookViewController.swift
//  AddressBookApp
//
//  Created by Eunjin Kim on 2018. 4. 12..
//  Copyright © 2018년 Eunjin Kim. All rights reserved.
//

import UIKit
import Contacts

class AddressBookViewController: UITableViewController {

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
        let store = CNContactStore()
        var contacts = [CNContact]()
        let keys = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName), CNContactPhoneNumbersKey as CNKeyDescriptor, CNContactEmailAddressesKey as CNKeyDescriptor]
        let request = CNContactFetchRequest(keysToFetch: keys)
        
        // 주소록에 접근해서 정보 가져오기
        store.requestAccess(for: .contacts, completionHandler: {
            (granted, err) in
            if granted {
                do {
                    try store.enumerateContacts(with: request) {
                        (contact, stop) in
                        if !contact.phoneNumbers.isEmpty {
                            contacts.append(contact)
                        }
                    }
                    for info in contacts {
                        guard let phone = info.phoneNumbers[0].value.value(forKey: "digits") else {
                            return
                        }
                        let name = info.familyName + info.givenName
                        let email = info.emailAddresses
                        print(phone)
                        print(name)
                        print(email)
                    }
                }
                catch {
                    print("unable to fetch contacts")
                }
            }
            else {
                let toast = UIAlertController(title: "알림", message: "주소록 권한이 필요합니다.", preferredStyle: .alert)
                toast.addAction(UIAlertAction(title: "확인", style: .default, handler: {
                    (Action) -> Void in
                    let settingURL = NSURL(string: UIApplicationOpenSettingsURLString)! as URL
                    UIApplication.shared.open(settingURL, options: [:], completionHandler: nil)
                }))
                self.present(toast, animated: true, completion: nil)
            }
        })
        
        // 가져온 정보를 AddressTableViewCell에 담기
        
        
        
        
        return UITableViewCell()
    }

}
