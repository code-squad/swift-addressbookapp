//
//  HolidayTableViewCell.swift
//  AddressBookApp
//
//  Created by YOUTH2 on 2018. 6. 5..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit

class HolidayTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
