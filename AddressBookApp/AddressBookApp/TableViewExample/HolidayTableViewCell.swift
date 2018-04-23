
//
//  HolidayTableViewCell.swift
//  AddressBookApp
//
//  Created by yuaming on 17/04/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import UIKit

class HolidayTableViewCell: UITableViewCell {
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.weatherImageView.image = nil
        self.dateLabel.text = ""
        self.subtitleLabel.text = ""
    }
}

extension HolidayTableViewCell {
    func bind(_ holiday: Holiday) {
        self.dateLabel.text = holiday.date
        self.subtitleLabel.text = holiday.subtitle
        
        if holiday.image == "" {
            self.weatherImageView.backgroundColor = UIColor.gray
        } else {
            self.weatherImageView.image = UIImage(imageLiteralResourceName: holiday.image)
        }
    }
}
