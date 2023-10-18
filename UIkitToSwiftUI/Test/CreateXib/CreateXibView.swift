//
//  CreateXibView.swift
//  Test
//
//  Created by Thanh Duy on 19/06/2023.
//

import UIKit
import SnapKit

class CreateXibView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var testLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        testLabel.textColor = .red
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    override class func awakeFromNib() {
        super.awakeFromNib()
//        testLabel.textColor = .red
    }
    
    private func setupView() {
        Bundle.main.loadNibNamed("CreateXibView", owner: self)
        self.addSubview(contentView)
        contentView.frame = bounds
        backgroundColor = .red
//        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        contentView.translatesAutoresizingMaskIntoConstraints = false
    }
}

class TestXib: UIView {
    private lazy var createXibView: CreateXibView = {
        let view = CreateXibView(frame: .zero)
        view.backgroundColor = .red
        view.testLabel.text = "asdfasdfasdfafd"
        return view
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(createXibView)
        createXibView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(200)
            make.centerY.equalToSuperview()
        }
    }
}
