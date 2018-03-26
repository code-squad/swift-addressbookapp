//
//  HolidayTableViewCell.swift
//  AddressBookApp
//
//  Created by TaeHyeonLee on 2018. 3. 26..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import UIKit

class HolidayTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
