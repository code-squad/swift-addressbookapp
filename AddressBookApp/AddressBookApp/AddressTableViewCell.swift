//
//  AddressTableViewCell.swift
//  AddressBookApp
//
//  Created by YOUTH2 on 2018. 6. 7..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit

class AddressTableViewCell: UITableViewCell {
    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var tellLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setCell(data: AddressData) {
        self.nameLabel.text = data.givenName + " " + data.familyName
        self.emailLabel.text = data.emailAddress
        self.tellLabel.text = data.phoneNumber
        if let imageData = data.profileImage {
            self.profile.image = UIImage(data: imageData)
        } else {
            self.profile.image = UIImage(named: "addressbook-default-profile")
        }

    }

}
