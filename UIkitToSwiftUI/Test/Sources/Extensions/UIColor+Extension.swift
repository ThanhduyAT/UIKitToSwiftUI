//
//  UIColor+Extension.swift
//  Test
//
//  Created by Thanh Duy on 29/08/2023.
//

import Foundation
import UIKit

extension UIColor {
    convenience init?(hex: String, alpha: CGFloat = 1.0) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        if (cString.count) != 6 {
            return nil
        }

        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}

extension UIColor {

    static let light = UIColor(hex: "FFFFFF")
    static let grayLow = UIColor(hex: "1D4D64", alpha: 0)
    static let grayMedium = UIColor(hex: "1D4D64", alpha: 0.61)
    static let grayHight = UIColor(hex: "1D4D64", alpha: 1)
    
    
    static func random() -> UIColor {
        let r:CGFloat = CGFloat(arc4random_uniform(255)) / 255.0
        let g:CGFloat = CGFloat(arc4random_uniform(255)) / 255.0
        let b:CGFloat = CGFloat(arc4random_uniform(255)) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
}


