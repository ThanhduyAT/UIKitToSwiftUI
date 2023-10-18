//
//  SkeletonCell.swift
//  Test
//
//  Created by Thanh Duy on 15/08/2023.
//

import UIKit
import SnapKit

class SkeletonCell: UITableViewCell {

//    let titleLabel = UIView()
    let titleLabel = UILabel()
    let titleLayer = CAGradientLayer()

//    let yearLabel = UIView()
    let yearLabel = UILabel()
    let yearLayer = CAGradientLayer()

    var game: Game? {
        didSet {
            guard let game = game else { return }
            titleLabel.text = game.title
            yearLabel.text = game.year
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLayer.frame = titleLabel.bounds
        titleLayer.cornerRadius = titleLabel.bounds.height / 2
        
        yearLayer.frame = yearLabel.bounds
        yearLayer.cornerRadius = yearLabel.bounds.height / 2
    }
}

class ProductCardLoadingCollectionViewCell: UITableViewCell {
    private lazy var productView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 20
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    private let productLayer = CAGradientLayer()
    
    private lazy var titleLabel: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 20
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    private let titleLayer = CAGradientLayer()
    
    private lazy var desLabel: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 20
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    private let desLayer = CAGradientLayer()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        productLayer.frame = productView.bounds
        productLayer.cornerRadius = 20
        
        titleLayer.frame = titleLabel.bounds
        titleLayer.cornerRadius = 20
        
        desLayer.frame = desLabel.bounds
        desLayer.cornerRadius = 20
    }
}

extension ProductCardLoadingCollectionViewCell: SkeletonLoadable {
    private func setupUI() {
        productLayer.startPoint = CGPoint(x: 0, y: 0.5)
        productLayer.endPoint = CGPoint(x: 1, y: 0.5)
        productView.layer.addSublayer(productLayer)
        
        let productGroup = makeAnimationGroup()
        productGroup.beginTime = 0.0
        productLayer.add(productGroup, forKey: "productGroup")
        
        titleLayer.startPoint = CGPoint(x: 0, y: 0.5)
        titleLayer.endPoint = CGPoint(x: 1, y: 0.5)
        titleLabel.layer.addSublayer(titleLayer)
        
        let titleGroup = makeAnimationGroup()
        titleGroup.beginTime = 0.0
        titleLayer.add(titleGroup, forKey: "titleGroup")
        
        desLayer.startPoint = CGPoint(x: 0, y: 0.5)
        desLayer.endPoint = CGPoint(x: 1, y: 0.5)
        desLabel.layer.addSublayer(desLayer)
        
        let desGroup = makeAnimationGroup()
        desGroup.beginTime = 0.0
        desLayer.add(desGroup, forKey: "desGroup")
        
        contentView.addSubview(productView)
        productView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(200)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(productView.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(24)
        }
        
        contentView.addSubview(desLabel)
        desLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(24)
            make.bottom.equalToSuperview()
        }
    }
}

extension SkeletonCell {

    func setup() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLayer.startPoint = CGPoint(x: 0, y: 0.5)
        titleLayer.endPoint = CGPoint(x: 1, y: 0.5)
        titleLabel.layer.addSublayer(titleLayer)

        yearLayer.startPoint = CGPoint(x: 0, y: 0.5)
        yearLayer.endPoint = CGPoint(x: 1, y: 0.5)
        yearLabel.layer.addSublayer(yearLayer)

        let titleGroup = makeAnimationGroup()
        titleGroup.beginTime = 0.0
        titleLayer.add(titleGroup, forKey: "backgroundColor")
        
        let yearGroup = makeAnimationGroup(previousGroup: titleGroup)
        yearLayer.add(yearGroup, forKey: "backgroundColor")
    }
    
    func layout() {
        addSubview(titleLabel)
        addSubview(yearLabel)
        
//        titleLabel.snp.makeConstraints { make in
//            make.left.bottom.top.equalToSuperview()
//            make.height.equalTo(40)
//            make.width.equalTo(200)
//        }
//
//        yearLabel.snp.makeConstraints { make in
//            make.left.equalTo(titleLabel.snp.right).offset(8)
//            make.right.equalToSuperview()
//            make.height.equalTo(40)
//            make.top.equalToSuperview()
//        }
        
        
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            yearLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: titleLabel.trailingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: yearLabel.trailingAnchor, multiplier: 2),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            yearLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        
        yearLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
    }
}

// inherit
extension SkeletonCell: SkeletonLoadable {}

extension UIColor {

    static var gradientDarkGrey: UIColor {
        return UIColor(red: 239 / 255.0, green: 241 / 255.0, blue: 241 / 255.0, alpha: 1)
    }

    static var gradientLightGrey: UIColor {
        return UIColor(red: 201 / 255.0, green: 201 / 255.0, blue: 201 / 255.0, alpha: 1)
    }

}
