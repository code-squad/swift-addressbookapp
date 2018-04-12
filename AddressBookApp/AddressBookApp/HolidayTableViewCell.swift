//
//  HolidayTableViewCell.swift
//  AddressBookApp
//
//  Created by Eunjin Kim on 2018. 4. 9..
//  Copyright © 2018년 Eunjin Kim. All rights reserved.
//

import UIKit

class HolidayTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func makeHolidayCell(data: CellData) {
        self.dateLabel.text = data.title
        self.subtitleLabel.text = data.subTitle
        self.weatherImage.backgroundColor = UIColor.gray
        if data.imageName != "" {
            self.weatherImage.image = UIImage(named: data.imageName)
        }
    }

}
