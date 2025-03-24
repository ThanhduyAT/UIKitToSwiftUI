//
//  CollectionViewInsideTableView.swift
//  Test
//
//  Created by Thanh Duy on 15/09/2023.
//

import Foundation
import UIKit
import SnapKit
import SwiftUI

class DynamicHeightCollectionView: UICollectionView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return collectionViewLayout.collectionViewContentSize
    }
}

class CollectionViewInsideTableView: UITableViewCell {
    private(set) lazy var collectionView: DynamicHeightCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width/2-40, height: 1)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        let c = DynamicHeightCollectionView(frame: .zero, collectionViewLayout: layout)
        c.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        c.delegate = self
        c.dataSource = self
        c.isScrollEnabled = false
        c.register(of: CollectionViewInsideTableViewProductCardLoadingCollectionViewCell.self)
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        collectionView.reloadData()
//    }
}

extension CollectionViewInsideTableView: UICollectionViewDelegateFlowLayout {
    
}

extension CollectionViewInsideTableView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(of: CollectionViewInsideTableViewProductCardLoadingCollectionViewCell.self, indexPath: indexPath) else { return UICollectionViewCell()}
//        cell.setName = "adsfasdfasdf"
        if indexPath == IndexPath(item: 0, section: 0) {
            cell.backgroundColor = .red
        } else {
            cell.backgroundColor = .clear
        }
        return cell
    }
}

class CollectionViewInsideTableViewProductCardLoadingCollectionViewCell: UICollectionViewCell {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        backgroundColor = .clear
    }
}

extension CollectionViewInsideTableViewProductCardLoadingCollectionViewCell: SkeletonLoadable {
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

struct CollectionViewInsideTableViews_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            TableViewController()
        }
    }
}
