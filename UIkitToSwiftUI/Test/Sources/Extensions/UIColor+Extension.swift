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

extension UIColor {
    static var primary: UIColor {
        return #colorLiteral(red: 0, green: 0.737254902, blue: 0.7647058824, alpha: 1) //00BCC3
    }
    
    static var disactive: UIColor {
        return #colorLiteral(red: 0.9411764706, green: 0.9568627451, blue: 0.9647058824, alpha: 1) //F0F4F6
    }
    
    static var heather: UIColor {
        return #colorLiteral(red: 0.8666666667, green: 0.9529411765, blue: 0.9411764706, alpha: 1) //DDF3F0
    }
    
    static var border: UIColor {
        return #colorLiteral(red: 0.9058823529, green: 0.937254902, blue: 0.9568627451, alpha: 1) //E7EFF4
    }
    
    static var background: UIColor {
        return #colorLiteral(red: 0.9450980392, green: 0.9568627451, blue: 0.9647058824, alpha: 1) //F1F4F6
    }
    
    static var lightRed: UIColor {
        return #colorLiteral(red: 1, green: 0.9647058824, blue: 0.9647058824, alpha: 1) //FFF6F6
    }

    static var line: UIColor {
        return #colorLiteral(red: 0.9294117647, green: 0.9450980392, blue: 0.9607843137, alpha: 1) //EDF1F5
    }
    
    static var titleDisactive: UIColor {
        return #colorLiteral(red: 0.7647058824, green: 0.8117647059, blue: 0.8431372549, alpha: 1) //C3CFD7
    }

    static var errorBorder: UIColor {
        return #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1) //FF0000
    }
    
    //8C9AA4
    static var greyTitle: UIColor {
        return #colorLiteral(red: 0.5490196078, green: 0.6039215686, blue: 0.6431372549, alpha: 1) //8C9AA4
    }
    
    static var lightBlue: UIColor {
        return #colorLiteral(red: 0.9215686275, green: 0.9960784314, blue: 1, alpha: 1) //EBFEFF
    }
    
    static var expired: UIColor {
        return #colorLiteral(red: 1, green: 0.5411764706, blue: 0, alpha: 1) //FF8A00
    }
}


