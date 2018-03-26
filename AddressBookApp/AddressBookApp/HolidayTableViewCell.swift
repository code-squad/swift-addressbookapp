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

    func setImage(with image: String) {
        if image == "" {
            weatherImage.backgroundColor = #colorLiteral(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        } else {
            weatherImage.image = UIImage(named: "weather-\(image)")
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
