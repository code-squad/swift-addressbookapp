//
//  AddressTableViewCell.swift
//  AddressBookApp
//
//  Created by oingbong on 30/11/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class AddressTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var telLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    func configure(from address: Address) {
        nameLabel.text = address.name
        telLabel.text = address.tel
        emailLabel.text = address.email
        profileImageView.image = UIImage(named: "addressbook-default-profile")
        if let profile = address.profile {
            profileImageView.image = UIImage(data: profile)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
