//
//  GradientView.swift
//  Test
//
//  Created by Thanh Duy on 29/08/2023.
//

import Foundation
import UIKit
import SnapKit

final class GradientView: UIView {
    private var gradientLayer: CAGradientLayer?

    convenience init(colors: [UIColor?], direction: GradientColorDirection = .vertical) {
        self.init(frame: .zero)
        gradientLayer = insertGradientLayer(colors: colors, opacity: 0.5, direction: direction)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer?.frame = bounds
    }
}

class TestGradientView: UIView {
    private lazy var testView: GradientView = {
//        let v = GradientView(colors: [.light, .grayLow, .grayMedium, .grayHight], direction: .horizontal)
        let v = GradientView(colors: [.grayLow, .grayHight], direction: .vertical)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var testView2: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 8
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = 2
//        addSubview(testView)
//        testView.snp.makeConstraints { make in
//            make.left.right.top.bottom.equalToSuperview()
//        }
        
        addSubview(testView2)
        testView2.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        testView2.setGradientBackground(colorTop: .white, colorBottom: .grayHight)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
