//
//  AddressTableViewCell.swift
//  AddressBookApp
//
//  Created by 조재흥 on 19. 4. 2..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

class AddressTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    //MARK: IBOutlet
    
    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var telLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    //MARK: - Methods
    //MARK: Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
