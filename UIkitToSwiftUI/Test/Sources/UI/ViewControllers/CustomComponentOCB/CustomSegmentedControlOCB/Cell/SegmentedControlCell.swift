//
//  SegmentedControlCell.swift
//  Test
//
//  Created by Thanh Duy on 14/11/2023.
//

import Foundation
import SnapKit
import Parchment

class SegmentedControlCell: PagingCell {
    private(set) lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 14)
        l.textAlignment = .center
        l.text = "adsfasdfadsfasdf"
        l.textColor = .blue
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private(set) lazy var iconImageView: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFit
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setPagingItem(_ pagingItem: PagingItem, selected _: Bool, options _: PagingOptions) {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        if let item = pagingItem as? SegementedControlItem {
            titleLabel.text = item.title
            iconImageView.image = UIImage(systemName: "house")
        }
    }
}
