//
//  AddressTableViewCell.swift
//  AddressBookApp
//
//  Created by yuaming on 23/04/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import UIKit
import Contacts

class AddressTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var telLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        nameLabel.text = ""
        telLabel.text = ""
        emailLabel.text = ""
        profileImageView.image = nil
    }
    
    func setContact(_ contact: Contact) {
        nameLabel.text = "\(contact.lastName)\(contact.firstName)"
        telLabel.text = contact.phoneNumber
        emailLabel.text = contact.email
        
        if let data = contact.imageData {
            profileImageView.image = UIImage(data: data)
        } else {
            profileImageView.image = UIImage(imageLiteralResourceName: "default-profile")
        }
    }
}
