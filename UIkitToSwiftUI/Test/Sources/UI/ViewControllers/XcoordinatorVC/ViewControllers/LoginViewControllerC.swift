//
//  LoginViewControllerC.swift
//  Test
//
//  Created by Thanh Duy on 09/11/2023.
//

import UIKit
import SnapKit

class LoginViewControllerC: UIViewController {
    private lazy var textView: UITextView = {
        let v = UITextView()
        v.text = ""
        v.backgroundColor = .gray
        v.layer.borderColor = UIColor.border.cgColor
        v.layer.borderWidth = 1
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var loginButton: UIButton = {
        let b = UIButton()
        b.setTitle("Login", for: .normal)
        b.backgroundColor = .blue
        b.setTitleColor(.white, for: .normal)
        b.layer.borderColor = UIColor.white.cgColor
        b.layer.borderWidth = 1
        b.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(40)
            make.centerY.equalToSuperview()
        }
        
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.left.right.equalTo(textView)
            make.top.equalTo(textView.snp.bottom).offset(30)
            make.height.equalTo(40)
        }
    }
    
    @objc func loginAction() {
        if textView.text != nil {
            
        }
    }
}
