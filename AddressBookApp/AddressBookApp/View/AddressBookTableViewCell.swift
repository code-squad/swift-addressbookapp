//
//  AddressBookTableViewCell.swift
//  AddressBookApp
//
//  Created by joon-ho kil on 8/21/19.
//  Copyright © 2019 길준호. All rights reserved.
//

import UIKit

class AddressBookTableViewCell: UITableViewCell {
    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var telLabel: UILabel!

    func putInfo(contactDTO: ContactDTO) {
        self.nameLabel.text = contactDTO.getName()
        
        if let telNumber = contactDTO.getTel() {
            self.telLabel.text = telNumber
        }
        
        if let emailAddress = contactDTO.getEmail() {
            self.emailLabel.text = emailAddress
        }
        
        if let imageData = contactDTO.getImage() {
            self.profile.image = UIImage(data: imageData)
        }
    }
}
