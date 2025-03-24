//
//  TestStackView.swift
//  Test
//
//  Created by Duy Thanh on 28/12/2023.
//

import Foundation
import UIKit
import SwiftUI
import SnapKit

class TestStackView: UIView {
    private var showText = true
    
    private lazy var containerView: UIView = {
        let v = UIView()
        v.backgroundColor = .red
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var label0: UILabel = {
        let v = UILabel()
        v.backgroundColor = .yellow
        v.text = "TExtxxxxssssx"
        v.font = UIFont.systemFont(ofSize: 15)
        v.textColor = .black
        return v
    }()
    
    private lazy var label1: UILabel = {
        let v = UILabel()
        v.backgroundColor = .yellow
        v.text = "TExtxxxxx"
        v.font = UIFont.systemFont(ofSize: 40)
        v.textColor = .black
        return v
    }()
    
    private lazy var label2: UILabel = {
        let v = UILabel()
        v.backgroundColor = .purple
        v.text = "TExtxxxxx"
        v.font = UIFont.systemFont(ofSize: 50)
        v.textColor = .black
        return v
    }()
    
    private lazy var stackView: UIStackView = {
        let s = UIStackView()
        s.backgroundColor = .white
        s.axis = .vertical
        return s
    }()
    
    private lazy var buttonView: UIButton = {
        let b = UIButton()
        b.addTarget(self, action: #selector(showTitle), for: .touchUpInside)
        b.backgroundColor = .blue
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("SHOW TEXT", for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    private lazy var viewBottom: UIView = {
        let v = UIView()
        v.backgroundColor = .lightGray
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        containerView.addSubview(label0)
        label0.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(30)
        }
        
        containerView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(label0.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        stackView.addArrangedSubview(label1)
        stackView.addArrangedSubview(label2)
        
        containerView.addSubview(viewBottom)
        viewBottom.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(30)
            make.height.equalTo(50)
            make.left.right.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        view.addSubview(buttonView)
        buttonView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(14)
            make.centerX.equalToSuperview()
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func showTitle() {
        if showText {
            UIView.animate(withDuration: 0.1) {
                self.label1.isHidden = false
            }
            showText = false
        } else {
            UIView.animate(withDuration: 0.1) {
                self.label1.isHidden = true
            }
            showText = true
        }
    }
}
class TestStackViewController: UIViewController {
    private lazy var v: TestStackView = {
        let v = TestStackView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(v)
        v.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}




//struct TestStackView_PreviewView: PreviewProvider {
//    static var previews: some View {
//        ViewControllerPreview {
//            TestStackViewController()
//        }
//    }
//}

class ViewTest: UIView {
    private lazy var viewS: UIView = {
        let v = UIView()
        v.backgroundColor = .red
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(viewS)
        viewS.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalToSuperview().multipliedBy(0.5)
            make.center.equalToSuperview()
        }
        
        let viewBlue = UIView()
        viewBlue.backgroundColor = .yellow
        viewS.addSubview(viewBlue)
        viewBlue.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(viewBlue.snp.width).multipliedBy(0.5)
            
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

class TestSnap: UIView {
    private lazy var redView: UIView = {
        let v = UIView()
        v.backgroundColor = .red
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(redView)
        redView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(redView.snp.width).multipliedBy(0.5)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

struct TestStackView_PreviewView: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            TestSnap()
        }
        .frame(width: 300, height: 300)
    }
}


