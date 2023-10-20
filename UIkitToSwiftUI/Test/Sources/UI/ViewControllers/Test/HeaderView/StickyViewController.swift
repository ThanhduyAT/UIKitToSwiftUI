//
//  StickyViewController.swift
//  Test
//
//  Created by Thanh Duy on 24/08/2023.
//

import UIKit
import SwiftUI
import SnapKit
import RxSwift
import RxRelay
import RxCocoa

class StickyViewController: UIViewController {
    private lazy var yellowView: UIView = {
        let v = UIView()
        v.backgroundColor = .systemYellow
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    private lazy var greenView: UIView = {
        let v = UIView()
        v.backgroundColor = .green
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var grayView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        v.layer.cornerRadius = 20
//        v.roundCorners(corners: [.topLeft, .topRight], radius: 30)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = .systemBlue
        v.bounces = false
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 300, height: 100)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(of: StickyCell.self)
        collection.delegate = self
        collection.dataSource = self
//        collection.layer.cornerRadius = 30
        collection.isScrollEnabled = false
        collection.bounces = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private lazy var cornerView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        [yellowView, collectionView, greenView].forEach { v in
//            scrollView.addSubview(v)
//        }
//
//        view.addSubview(scrollView)
//        let safeG = view.safeAreaLayoutGuide
//        let contentG = scrollView.contentLayoutGuide
//        let frameG = scrollView.frameLayoutGuide
//
//
//
//        NSLayoutConstraint.activate([
//            scrollView.topAnchor.constraint(equalTo: safeG.topAnchor),
//            scrollView.leadingAnchor.constraint(equalTo: safeG.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: safeG.trailingAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: safeG.bottomAnchor),
//
//            yellowView.leadingAnchor.constraint(equalTo: frameG.leadingAnchor),
//            yellowView.trailingAnchor.constraint(equalTo: frameG.trailingAnchor),
//            yellowView.heightAnchor.constraint(equalToConstant: 100.0),
//            yellowView.topAnchor.constraint(equalTo: frameG.topAnchor),
//
//
//            greenView.leadingAnchor.constraint(equalTo: frameG.leadingAnchor),
//            greenView.trailingAnchor.constraint(equalTo: frameG.trailingAnchor, constant: -40),
//            greenView.heightAnchor.constraint(equalToConstant: 100.0),
//            greenView.topAnchor.constraint(greaterThanOrEqualTo: frameG.topAnchor),
//
//            collectionView.leadingAnchor.constraint(equalTo: contentG.leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: contentG.trailingAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: contentG.bottomAnchor),
//            collectionView.widthAnchor.constraint(equalTo: frameG.widthAnchor),
//
////            redView.leadingAnchor.constraint(equalTo: contentG.leadingAnchor),
////            redView.trailingAnchor.constraint(equalTo: contentG.trailingAnchor),
////            redView.bottomAnchor.constraint(equalTo: contentG.bottomAnchor),
////            redView.heightAnchor.constraint(equalToConstant: 1000),
////            redView.widthAnchor.constraint(equalTo: frameG.widthAnchor),
//        ])
//
//        var c: NSLayoutConstraint!
//
//        // these constraints need Priority adjustments
//
//        // keep green view above red view, until green view is at top
//        c = collectionView.topAnchor.constraint(equalTo: greenView.bottomAnchor, constant: 20)
//        c.priority = .defaultHigh
//        c.isActive = true
//
//        // since yellow and green view Heights are constant 100-pts each
//        c = collectionView.topAnchor.constraint(equalTo: contentG.topAnchor, constant: 220)
//        c.isActive = true
//
//
//
//
//        scrollView.layoutIfNeeded()
//        collectionView.heightAnchor.constraint(equalToConstant: collectionView.contentSize.height).isActive = true
//
//
//        view.insertSubview(grayView, aboveSubview: greenView)
//        grayView.snp.makeConstraints { make in
//            make.top.equalTo(greenView.snp.bottom)
//            make.left.right.equalToSuperview()
//            make.height.equalTo(40)
//        }
//
//
//        let bag = DisposeBag()
////        self.collectionView.rx.contentOffset.map { $0.y}
////            .withUnretained(self)
////            .subscribe { base, y in
////                if y <= 0 {
////                    base.scrollView.isScrollEnabled = true
////                } else {
////                    base.scrollView.isScrollEnabled = false
////                }
////            }.disposed(by: bag)
//
//        self.scrollView.rx.contentOffset.map { $0.y}
//            .withUnretained(self)
//            .subscribe { base, y in
//                if y >= 120 {
//                    base.scrollView.isScrollEnabled = false
//                    base.collectionView.isScrollEnabled = true
//                } else {
//                    base.collectionView.isScrollEnabled = false
//                }
//            }.disposed(by: bag)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        [yellowView, collectionView, greenView].forEach { v in
//            scrollView.addSubview(v)
//        }

        scrollView.addSubview(yellowView)
        scrollView.addSubview(collectionView)
        scrollView.addSubview(greenView)
        
        greenView.addSubview(cornerView)
        cornerView.snp.makeConstraints { make in
            make.bottom.equalTo(greenView.snp.bottom)
            make.height.equalTo(20)
            make.left.right.equalToSuperview()
        }
        view.addSubview(scrollView)
        
        let safeG = view.safeAreaLayoutGuide
        let contentG = scrollView.contentLayoutGuide
        let frameG = scrollView.frameLayoutGuide
        
        scrollView.snp.makeConstraints { make in
            make.left.right.bottom.top.equalTo(safeG)
        }
        
        yellowView.snp.makeConstraints { make in
            make.left.equalTo(frameG.snp.left)
            make.right.equalTo(frameG.snp.right)
            make.top.equalTo(contentG.snp.top)
            make.height.equalTo(100)
        }
        
        greenView.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.left.equalTo(frameG.snp.left)
            make.right.equalTo(frameG.snp.right)
            make.top.greaterThanOrEqualTo(frameG.snp.top)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(greenView.snp.bottom).priority(.high)
            make.top.equalTo(contentG.snp.top).offset(200)
            make.left.equalTo(contentG.snp.left)
            make.right.equalTo(contentG.snp.right)
            make.bottom.equalTo(contentG.snp.bottom)
            make.width.equalTo(frameG.snp.width)
            make.height.equalTo(collectionView.contentSize.height)
        }
        
        scrollView.layoutIfNeeded()
        collectionView.snp.updateConstraints { make in
            make.height.equalTo(collectionView.contentSize.height)
        }
        
        cornerView.roundCorners(topLeft: 20, topRight: 20, bottomLeft: 0, bottomRight: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.delegate = self
    }
}

extension StickyViewController: UIScrollViewDelegate, UIGestureRecognizerDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        yellowView.isHidden = scrollView.contentOffset.y >= 100
//
//        if scrollView.contentOffset.y >= 120 {
//            self.scrollView.isScrollEnabled = false
//            self.collectionView.isScrollEnabled = true
//        }
    }
}

extension StickyViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 200
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(of: StickyCell.self ,indexPath: indexPath) else { return UICollectionViewCell() }
        return cell
    }
    
    
}

class StickyCell: UICollectionViewCell {
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.text = "123123"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .yellow
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}


struct StickyViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            StickyViewController()
        }
    }
}


