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
    @IBOutlet weak var tellLabel: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
