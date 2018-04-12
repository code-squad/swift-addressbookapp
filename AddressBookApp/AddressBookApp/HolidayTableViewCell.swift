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
    
    func makeCellData(cellData: CellData) {
        // 딱 필요한 데이터란 무엇이 있을까? - title, subTitle, imageName
        self.dateLabel.text = cellData.title
        self.subtitleLabel.text = cellData.subTitle
        self.weatherImage.backgroundColor = UIColor.gray
        self.weatherImage.image = UIImage(named: cellData.imageName)
    }

}
