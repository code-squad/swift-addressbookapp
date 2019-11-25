//
//  AddressCell.swift
//  AddressBookApp
//
//  Created by CHOMINJI on 2019/11/23.
//  Copyright © 2019 cmindy. All rights reserved.
//

import Contacts
import UIKit

class AddressCell: UITableViewCell {
    
    // MARK: - Vars
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var telLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpAttributes()
    }
}

// MARK: - Attributes

extension AddressCell {
    private func setUpAttributes() {
        setUpImageView()
        setUpLabels()
    }
    
    private func setUpImageView() {
        profileImageView.contentMode = .scaleAspectFill
    }
    
    private func setUpLabels() {
        nameLabel.font = UIFont.systemFont(ofSize: 18.0)
        nameLabel.textColor = .black
        nameLabel.textAlignment = .left
        
        telLabel.font = UIFont.systemFont(ofSize: 17.0, weight: .bold)
        telLabel.textColor = .lightGray
        telLabel.textAlignment = .left
        
        emailLabel.font = UIFont.systemFont(ofSize: 16.0)
        emailLabel.textColor = .darkGray
        emailLabel.textAlignment = .right
    }
}

// MARK: - Configure

extension AddressCell {
    func configure(_ contact: Contact) {
        if let imageData = contact.profilePictureData {
            profileImageView.image = UIImage(data: imageData)
        } else {
            profileImageView.image = UIImage(named: "imgDefaultProfile")
        }
        
        nameLabel.text = contact.fullName ?? ""
        emailLabel.text = contact.email ?? ""
        telLabel.text = contact.phoneNumber ?? ""
    }
}
