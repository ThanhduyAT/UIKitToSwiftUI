//
//  CALayer+Extension.swift
//  Test
//
//  Created by Thanh Duy on 28/08/2023.
//

import Foundation
import UIKit

extension CALayer {
    func roundCornerss(radius: CGFloat, mask: CACornerMask) {
        cornerRadius = radius
        maskedCorners = mask
    }
}
