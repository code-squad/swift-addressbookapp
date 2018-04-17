
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
    
    static let cellIndentifier = "Cell"
    static let cellHeight = CGFloat(80)
    
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
    
    func bindImage(_ imageName: String) {
        if imageName == "" {
            self.weatherImageView.backgroundColor = UIColor.gray
        } else {
            self.weatherImageView.image = UIImage(imageLiteralResourceName: imageName)
        }
    }
}
