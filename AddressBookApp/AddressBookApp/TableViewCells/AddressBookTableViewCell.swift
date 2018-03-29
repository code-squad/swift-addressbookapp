//
//  AddressBookTableViewCell.swift
//  AddressBookApp
//
//  Created by TaeHyeonLee on 2018. 3. 27..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import UIKit
import Contacts

class AddressBookTableViewCell: UITableViewCell {

    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var telLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!

    func setCell(with contact: CNContact) {
        setProfile(with: contact.imageData)
        setName(faimly: contact.familyName, given: contact.givenName)
        setTel(among: contact.phoneNumbers)
        setEmail(among: contact.emailAddresses)
    }

    private func setProfile(with imageData: Data?) {
        if let imageData = imageData {
            self.profile.image = UIImage(data: imageData)
        } else {
            self.profile.image = UIImage(named: Keyword.defaultImage.value)
        }
    }

    private func setName(faimly: String, given: String) {
        nameLabel.text = "\(faimly) \(given)".trimmingCharacters(in: [" "])
    }

    private func setTel(among phoneNumbers: [CNLabeledValue<CNPhoneNumber>]) {
        telLabel.text = phoneNumbers.count > 0
            ? CNLabeledValue<CNPhoneNumber>.localizedString(forLabel: phoneNumbers.first!.value.stringValue)
            : ""
    }

    private func setEmail(among emailAddresses: [CNLabeledValue<NSString>]) {
        emailLabel.text = emailAddresses.count > 0
            ? CNLabeledValue<NSString>.localizedString(forLabel: emailAddresses.first!.label!)
            : ""
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
