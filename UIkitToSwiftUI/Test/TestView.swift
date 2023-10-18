//
//  TestView.swift
//  Test
//
//  Created by Thanh Duy on 12/12/2022.
//

import Foundation
import SwiftUI

import UIKit
import SnapKit

class FilterBottomButton: UIButton {
    var text: String? {
        didSet {
            setTitle(text, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setTitleColor(.red, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 21)
        setImage(UIImage(named: "ic_dot_filter"), for: .normal)
        semanticContentAttribute = .forceLeftToRight
//        imageEdgeInsets = UIEdgeInsets(top: 21, left: 16, bottom: 21, right: 4)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

class TestButton: UIView {
    private lazy var button: FilterBottomButton = {
       let button = FilterBottomButton()
        button.text = "tester"
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(button)
        button.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}

//class FilterTopView: UIView {
//    var didTapFilter: (() -> Void)?
//
//    private lazy var vStack: UIStackView = {
//        let vStack = UIStackView(frame: .zero)
//        vStack.distribution = .equalSpacing
//        vStack.alignment = .fill
//        vStack.axis = .vertical
//        vStack.spacing = 0
//        vStack.translatesAutoresizingMaskIntoConstraints = false
//        return vStack
//    }()
//
//    private lazy var headerView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .white
//        return view
//    }()
//
//    private lazy var filterButton: UIButton = {
//        let button = UIButton()
//        button.backgroundColor = .white
//        button.cornerRadius = 8
//        button.setTitleColor(.white, for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.layer.borderWidth = 1
//        button.layer.borderColor = UIColor.black.cgColor
//
//        button.addTarget(self, action: #selector(filterAction), for: .touchUpInside)
//        return button
//    }()
//
//    private lazy var iconFilter: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "iconFilterNew")
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//
//    private lazy var counterFilter: UILabel = {
//        let label = UILabel()
//        label.text = "+9"
//        label.font = .mediumFont(10)
//        label.textColor = .white
//        label.textAlignment = .center
//        label.backgroundColor = .viewYellowCounter
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.layer.borderWidth = 1
//        label.layer.cornerRadius = 9
//        label.layer.borderColor = UIColor.viewYellowCounter?.cgColor
//        label.layer.masksToBounds = true
//        return label
//    }()
//
//    private lazy var textFilter: UILabel = {
//        let textFilter = UILabel()
//        textFilter.text = "Lọc"
//        textFilter.font = .semiBoldFont(14)
//        textFilter.textColor = .black
//        textFilter.textAlignment = .center
//        textFilter.translatesAutoresizingMaskIntoConstraints = false
//        return textFilter
//    }()
//
//    private lazy var filterCollectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        layout.scrollDirection = .horizontal
//        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//
//        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
//        collectionView.register(FilterOptionViewCell.self, forCellWithReuseIdentifier: "filterOptionViewCell")
//        collectionView.backgroundColor = .white
//        collectionView.showsHorizontalScrollIndicator = false
////        collectionView.delegate = self
////        collectionView.dataSource = self
//        return collectionView
//    }()
//
//    private lazy var scrollView: UIScrollView = {
//        let scrollView = UIScrollView()
//        scrollView.contentSize = CGSize( width: 500, height: scrollView.frame.size.height)
//        scrollView.isScrollEnabled = true
//        scrollView.isPagingEnabled = true
//        scrollView.showsHorizontalScrollIndicator = true
//        return scrollView
//    }()
//
//    private lazy var bottomView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .white
//        return view
//    }()
//
//    private lazy var relatedButton: FilterBottomButton = {
//        let button = FilterBottomButton()
//        button.text = "Liên quan"
//        return button
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        addViews()
//        addConstraints()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError()
//    }
//
//    private func addViews() {
//        addSubview(vStack)
//        vStack.addSubview(headerView)
//        headerView.addSubview(filterButton)
//        filterButton.addSubview(iconFilter)
//        filterButton.addSubview(counterFilter)
//        filterButton.addSubview(textFilter)
//        headerView.addSubview(filterCollectionView)
//
//        addSubview(bottomView)
//        bottomView.addSubview(scrollView)
//        scrollView.addSubview(relatedButton)
//    }
//
//    private func addConstraints() {
//        /// Top
//        vStack.snp.makeConstraints { make in
//            make.left.right.top.bottom.equalToSuperview()
//        }
//
//        headerView.snp.makeConstraints { make in
//            make.left.right.top.equalToSuperview()
//            make.height.equalTo(43)
//        }
//
//        filterButton.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(8)
//            make.left.equalToSuperview().offset(16)
//            make.height.equalTo(32)
//            make.width.equalTo(65)
//        }
//
//        iconFilter.snp.makeConstraints { maker in
//            maker.width.height.equalTo(16)
//            maker.top.left.equalTo(8)
//        }
//
//        counterFilter.snp.makeConstraints { make in
//            make.left.top.equalToSuperview().offset(3)
//            make.width.height.equalTo(16)
//        }
//
//        textFilter.snp.makeConstraints { make in
//            make.left.equalTo(iconFilter.snp.right).offset(6)
//            make.right.equalToSuperview().offset(-8)
//            make.centerY.equalTo(iconFilter)
//        }
//
//        filterCollectionView.snp.makeConstraints { make in
//            make.left.equalTo(filterButton.snp.right).offset(8)
//            make.right.equalToSuperview().offset(8)
//            make.centerY.equalTo(filterButton)
//            make.height.equalTo(32)
//        }
//
//        bottomView.snp.makeConstraints { make in
//            make.left.equalToSuperview().offset(16)
//            make.right.bottom.equalToSuperview()
//            make.height.equalTo(43)
//        }
//        /// Bottom
//        scrollView.snp.makeConstraints { make in
//            make.center.size.equalTo(bottomView)
//        }
//
//        relatedButton.snp.makeConstraints { make in
//            make.top.bottom.left.equalToSuperview()
//            make.width.equalTo(30)
//        }
//    }
//
//    @objc func filterAction() {
//        self.didTapFilter?()
//    }
//}
