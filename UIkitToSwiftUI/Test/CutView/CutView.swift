//
//  CutView.swift
//  Test
//
//  Created by Thanh Duy on 14/09/2023.
//

import Foundation
import UIKit
import SwiftUI
import SnapKit

class CutViewController: UIViewController {
    private lazy var largeView: UIView = {
        let v = UIView()
        v.backgroundColor = .red
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var cutView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        v.layer.cornerRadius = 12
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .blue
//        view.addSubview(largeView)
//
//
//        largeView.snp.makeConstraints { make in
//            make.left.right.bottom.top.equalToSuperview()
//        }
//        largeView.addSubview(cutView)
//        cutView.snp.makeConstraints { make in
//            make.centerX.centerY.equalToSuperview()
//            make.size.equalTo(100)
//        }
        let l = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
        l.text = "asdf"
        
        view.addSubview(l)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
                
        // Create the initial layer from the view bounds.
        let maskLayer = CAShapeLayer()
        maskLayer.frame = largeView.bounds
        maskLayer.fillColor = UIColor.black.cgColor

        // Create the path.
        let path = UIBezierPath(rect: largeView.bounds)
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd

        // Append the overlay image to the path so that it is subtracted.
//        path.append(UIBezierPath(rect: cutView.frame))
        path.append(UIBezierPath(roundedRect: cutView.frame, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 16, height: 16)))
        maskLayer.path = path.cgPath

        // Set the mask of the view.
        largeView.layer.mask = maskLayer

    }
}

struct CutViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            CutViewController()
        }
    }
}

