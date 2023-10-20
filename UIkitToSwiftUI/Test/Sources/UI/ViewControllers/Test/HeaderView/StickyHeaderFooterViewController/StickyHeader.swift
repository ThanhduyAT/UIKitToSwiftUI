//
//  StickyHeader.swift
//  Test
//
//  Created by Thanh Duy on 30/08/2023.
//

import Foundation
import SnapKit
import UIKit

class StickyHeader: UICollectionReusableView {
    var setTitle: String? {
        didSet {
            guard let title = setTitle else { return }
            stickyTitle.text = title
        }
    }

    // MARK: - Properties
    private lazy var stickyTitle: UILabel = {
        let l = UILabel()
        l.text = "asdf"
        l.textColor = .red
        l.textAlignment = .center
        l.font = .systemFont(ofSize: 40)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(stickyTitle)
        stickyTitle.snp.makeConstraints { make in
            make.left.right.bottom.top.equalToSuperview()
        }
        stickyTitle.textColor = .white
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

class HeaderTest: UICollectionReusableView {
    var setTitle: String? {
        didSet {
            guard let title = setTitle else { return }
            stickyTitle.text = title
        }
    }

    // MARK: - Properties
    private lazy var stickyTitle: UILabel = {
        let l = UILabel()
        l.text = "asdf"
        l.textColor = .red
        l.textAlignment = .center
        l.font = .systemFont(ofSize: 40)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        
        addSubview(stickyTitle)
        stickyTitle.snp.makeConstraints { make in
            make.left.right.bottom.top.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}



