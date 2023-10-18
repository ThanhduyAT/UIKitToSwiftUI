//
//  PopupSuccess.swift
//  Test
//
//  Created by Thanh Duy on 29/06/2023.
//

import UIKit
import SnapKit

class PopupSuccess: UIView {
    private lazy var successView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "iconBug")
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Xác minh thành công"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        applySubView()
        applyConstraint()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func applySubView() {
        addSubview(successView)
        successView.addSubview(imageView)
        successView.addSubview(titleLabel)
    }
    
    private func applyConstraint() {
        successView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(278)
            make.height.equalTo(232)
        }
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.top.equalToSuperview().offset(36)
            make.left.equalToSuperview().offset(89)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(36)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(24)
        }
    }
}
