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
    
    func set(_ dto: AddressDTO) {
        let defaultProfileName = "addressbook-default-profile"
        
        let phoneNumber = dto.phoneNumbers.first?.value.stringValue
        let email = dto.email.first?.value
        nameLabel.text = dto.givenName + " " + dto.familyName
        telLabel.text = phoneNumber
        emailLabel.text = email as String?
        if let imageData = dto.imageData { profileImageView.image = UIImage(data: imageData) }
        else { profileImageView.image = UIImage(named: defaultProfileName) }
    }
}
