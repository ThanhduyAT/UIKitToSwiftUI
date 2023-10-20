//
//  UIAnimation.swift
//  Test
//
//  Created by Thanh Duy on 04/07/2023.
//

import Foundation
import SnapKit
import UIKit

class UIAnimation: UIView {
    private lazy var testButton: UIButton = {
        let button = UIButton()
        button.setTitle("Transition", for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var tranView: UIView = {
        let view = UIView()
        view.backgroundColor = .cyan
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(testButton)
        testButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(testButton.snp.width).multipliedBy(0.5)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(1.5)
        }
        
        addSubview(tranView)
        tranView.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(200)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.5)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc func buttonAction() {
//        UIView.animate(withDuration: 3, delay: 1, options: [.curveEaseInOut ,.autoreverse]) {
//            self.tranView.snp.remakeConstraints { make in
//                make.width.equalTo(300)
//                make.height.equalTo(200)
//                make.centerX.equalToSuperview()
//                make.centerY.equalToSuperview().multipliedBy(0.5)
//            }
//            self.layoutIfNeeded()
//        }
        
        UIView.animate(withDuration: 3, delay: 1, options: [.curveEaseInOut ,.autoreverse], animations: {
            self.tranView.snp.remakeConstraints { make in
                make.width.equalTo(400)
                make.height.equalTo(300)
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview().multipliedBy(0.5)
            }
            self.tranView.alpha = 0.0
            self.layoutIfNeeded()
        }, completion: {_ in
            self.tranView.snp.updateConstraints { make in
                make.width.equalTo(300)
                make.height.equalTo(200)
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview().multipliedBy(0.5)
            }

        })
    }
}
