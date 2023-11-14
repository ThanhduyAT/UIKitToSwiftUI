//
//  TabbarCollectionViewCell.swift
//  Test
//
//  Created by Thanh Duy on 03/09/2023.
//

import Foundation
import UIKit
import SnapKit

class TabBarCollectionViewCellID: UICollectionViewCell {
    var setName: String? {
        didSet {
            guard let setName = setName else { return }
            titleLabel.text = setName
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14)
        l.textColor = .black
        l.textAlignment = .center
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = .white
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(30)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
