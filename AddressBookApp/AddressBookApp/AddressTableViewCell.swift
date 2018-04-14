//
//  AddressTableViewCell.swift
//  AddressBookApp
//
//  Created by Eunjin Kim on 2018. 4. 12..
//  Copyright © 2018년 Eunjin Kim. All rights reserved.
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
    
    func makeAddressCell(data: ContactData) {
        self.profileImageView.image = UIImage(data: data.image)
        self.nameLabel.text = data.name
        self.telLabel.text = data.phoneNumber
        self.emailLabel.text = data.email
    }

}

