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
    
    
    func makeCellData(indexPath: IndexPath, holidayData: HolidayDataLoader) {
        self.dateLabel.text = holidayData.json[indexPath.row][Constant.title.rawValue]
        self.subtitleLabel.text = holidayData.json[indexPath.row][Constant.subTitle.rawValue]
        self.weatherImage.backgroundColor = UIColor.gray
        if let imageName = holidayData.json[indexPath.row][Constant.weatherImage.rawValue] {
            self.weatherImage.image = UIImage(named: imageName)
        }
    }

}
