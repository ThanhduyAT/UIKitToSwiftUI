//
//  SegmentedControlPagingView.swift
//  Test
//
//  Created by Thanh Duy on 13/11/2023.
//

import Foundation
import Parchment
import SnapKit

class SegmentedControlPagingView: PagingView {
    var menuHeightConstraint: NSLayoutConstraint?

    override func setupConstraints() {
        pageView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        menuHeightConstraint = collectionView.heightAnchor.constraint(equalToConstant: options.menuHeight)
        menuHeightConstraint?.isActive = true
        
        collectionView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
        }
        
        pageView.snp.makeConstraints { make in
            make.left.right.bottom.top.equalToSuperview()
        }
    }
}
