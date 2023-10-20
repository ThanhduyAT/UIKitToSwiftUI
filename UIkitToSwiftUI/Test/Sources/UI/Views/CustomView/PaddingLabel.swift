//
//  PaddingLabel.swift
//  Test
//
//  Created by Thanh Duy on 20/10/2023.
//

import Foundation
import UIKit

@IBDesignable class PaddingLabel: UILabel {
    @IBInspectable var topInset: CGFloat = 0.0
    @IBInspectable var bottomInset: CGFloat = 0.0
    @IBInspectable var leftInset: CGFloat = 10.0
    @IBInspectable var rightInset: CGFloat = 10.0

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
}
