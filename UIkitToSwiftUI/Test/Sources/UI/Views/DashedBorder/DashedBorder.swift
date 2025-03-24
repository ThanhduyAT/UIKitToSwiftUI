//
//  DashedBorder.swift
//  Test
//
//  Created by Duy Thanh on 18/03/2024.
//

import Foundation
import UIKit
import SwiftUI

class DashedBorder: UIView {
    private lazy var borderView: UIView = {
        let v = UIView()
//        v.backgroundColor = .yellow
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        addSubview(borderView)
        borderView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(200)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let dashedBorderLayer = borderView.addLineDashedStroke(pattern: [2, 5], radius: 10, color: UIColor.black.cgColor)
        borderView.layer.addSublayer(dashedBorderLayer)
    }
}

extension UIView {
    func addLineDashedStroke(pattern: [NSNumber]?, radius: CGFloat, color: CGColor) -> CALayer {
        let borderLayer = CAShapeLayer()
        borderLayer.strokeColor = color
        borderLayer.lineDashPattern = pattern
        borderLayer.frame = bounds
        borderLayer.fillColor = nil
        borderLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
        layer.addSublayer(borderLayer)
        return borderLayer
    }
}

#Preview(body: {
    ViewPreview {
        DashedBorder()
    }
    .frame(width: 400, height: 400)
})
