//
//  TabTableViewCell.swift
//  Test
//
//  Created by Thanh Duy on 03/09/2023.
//

import Foundation
import SnapKit
import UIKit

class TabTableViewCell: UITableViewCell {
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview().inset(20)
        }
    }

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
