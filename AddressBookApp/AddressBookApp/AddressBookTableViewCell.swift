//
//  AddressBookTableViewCell.swift
//  AddressBookApp
//
//  Created by joon-ho kil on 8/21/19.
//  Copyright © 2019 길준호. All rights reserved.
//

import UIKit
import Contacts

class AddressBookTableViewCell: UITableViewCell {
    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var telLabel: UILabel!

    func putInfo(contact: CNContact) {
        self.nameLabel.text = contact.familyName + " " + contact.givenName
        self.telLabel.text = (contact.phoneNumbers[0].value ).stringValue
        
        if let emailAddress = contact.emailAddresses.first {
            self.emailLabel.text = emailAddress.value as String
        }
        
        if let imageData = contact.imageData {
            self.profile.image = UIImage(data: imageData)
        }
    }
}
