//
//  AddressTableViewCell.swift
//  AddressbookApp
//
//  Created by 윤동민 on 01/04/2019.
//  Copyright © 2019 윤동민. All rights reserved.
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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func set(_ information: CNContact) {
        let fullName = CNContactFormatter.string(from: information, style: .fullName)
        let phoneNumber = information.phoneNumbers.first?.value.stringValue
        let email = information.emailAddresses.first?.value
        nameLabel.text = fullName
        telLabel.text = phoneNumber
        emailLabel.text = email as String?
        if let imageData = information.imageData { profileImageView.image = UIImage(data: imageData) }
        else { profileImageView.image = UIImage(named: "addressbook-default-profile") }
    }
}
