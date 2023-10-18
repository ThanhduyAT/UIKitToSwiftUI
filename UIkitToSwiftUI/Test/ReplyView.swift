//
//  ReplyView.swift
//  Test
//
//  Created by Thanh Duy on 16/06/2023.
//

import UIKit
import SnapKit

class ReplyView: UIView {
    private lazy var testCell: UICollectionViewCell = {
        let view = UICollectionViewCell(frame: .zero)
        view.backgroundColor = .red
        return view
    }()
    
    private lazy var textLabel: PaddingLabel = {
        let l = PaddingLabel()
        l.text = "12123"
        l.backgroundColor = .red
        l.layer.cornerRadius = 6
        l.layer.masksToBounds = true
        l.topInset = 4
        l.bottomInset = 10
        l.leftInset = 0
        l.rightInset = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var viewRed: UIView = {
       let v = UIView()
        v.backgroundColor = .red
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

//        let lable = UIlab
//        addSubview(viewRed)
//        viewRed.snp.makeConstraints { make in
//            make.height.equalTo(300)
//            make.width.equalToSuperview().inset(30)
//            make.centerX.centerY.equalToSuperview()
//        }
        
        
//        addSubview(textLabel)
//        textLabel.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.centerY.equalToSuperview()
//        }
        
//        addSubview(testCell)
//        testCell.snp.makeConstraints { make in
//            make.left.right.equalToSuperview()
//            make.centerY.equalToSuperview()
//            make.height.equalTo(300)
//        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        viewRed.roundCorners(topLeft: 10, topRight: 150, bottomLeft: 0, bottomRight: 150)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

@IBDesignable class PaddingLabel: UILabel {

    @IBInspectable var topInset: CGFloat = 0.0
    @IBInspectable var bottomInset: CGFloat = 0.0
    @IBInspectable var leftInset: CGFloat = 10.0
    @IBInspectable var rightInset: CGFloat = 10.0

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
}
