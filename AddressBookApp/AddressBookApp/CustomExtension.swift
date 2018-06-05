//
//  CustomExtension.swift
//  AddressBookApp
//
//  Created by YOUTH2 on 2018. 6. 5..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        }
    }
}
