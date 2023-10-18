//
//  AutoLayoutView.swift
//  Test
//
//  Created by Thanh Duy on 09/02/2023.
//

import UIKit
import SnapKit

class AutoLayoutView: UIView {
    private lazy var rectangleView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(rectangleView)
        rectangleView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalToSuperview().offset(30)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
