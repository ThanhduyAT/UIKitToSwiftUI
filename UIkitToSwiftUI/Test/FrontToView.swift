//
//  FrontToView.swift
//  Test
//
//  Created by Thanh Duy on 15/06/2023.
//

import Foundation
import UIKit
import SnapKit

class FrontToView: UIView {
    var changeColor: Bool = false
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var frontView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(backView)
//        addSubview(frontView)
        insertSubview(frontView, aboveSubview: backView)
        
//        bringSubviewToFront(frontView)
        
        backView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(400)
        }
        
        frontView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.centerY.equalToSuperview()
            make.height.equalTo(200)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backViewAction))
        backView.addGestureRecognizer(tapGesture)
        
        let tapBackgroundGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundAction))
        addGestureRecognizer(tapBackgroundGesture)
    }
    
    @objc func backgroundAction(){
        backgroundColor = .cyan
    }
    
    @objc func backViewAction() {
        
//        backView.backgroundColor = .blue
        if changeColor {
            changeColor = false
            backView.backgroundColor = .gray
        } else {
            changeColor = true
            backView.backgroundColor = .blue
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
