//
//  UIView+Extension.swift
//  Test
//
//  Created by Thanh Duy on 25/08/2023.
//

import Foundation
import UIKit

extension UIView {
    func roundCorners(topLeft: CGFloat = 0, topRight: CGFloat = 0, bottomLeft: CGFloat = 0, bottomRight: CGFloat = 0) {//(topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat) {
        let topLeftRadius = CGSize(width: topLeft, height: topLeft)
        let topRightRadius = CGSize(width: topRight, height: topRight)
        let bottomLeftRadius = CGSize(width: bottomLeft, height: bottomLeft)
        let bottomRightRadius = CGSize(width: bottomRight, height: bottomRight)
        let maskPath = UIBezierPath(shouldRoundRect: bounds, topLeftRadius: topLeftRadius, topRightRadius: topRightRadius, bottomLeftRadius: bottomLeftRadius, bottomRightRadius: bottomRightRadius)
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
    
    enum GradientColorDirection {
        case vertical
        case horizontal
    }
    
    func insertGradientLayer(colors: [UIColor?],
                             opacity: Float = 1,
                             direction: GradientColorDirection = .vertical) -> CAGradientLayer {

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.compactMap({$0?.cgColor})
        gradientLayer.opacity = opacity

        if case .horizontal = direction {
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        }

        gradientLayer.bounds = bounds
        gradientLayer.anchorPoint = .zero
        layer.insertSublayer(gradientLayer, at: 0)

        return gradientLayer
    }
    
    func setGradientBackground(colorTop: UIColor?, colorBottom: UIColor?) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom?.cgColor, colorTop?.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 5.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds

       layer.insertSublayer(gradientLayer, at: 0)
    }
}
