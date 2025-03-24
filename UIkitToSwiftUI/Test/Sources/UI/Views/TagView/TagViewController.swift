//
//  TagViewController.swift
//  Test
//
//  Created by Duy Thanh on 29/01/2024.
//

//import Foundation
//import UIKit
//import SwiftUI
//import SnapKit
//
//class TagCollectionViewCell: UICollectionViewCell {
//    static let reuseIdentifier = "TagCell"
//    
//    let label: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .center
//        label.textColor = .white
//        label.backgroundColor = .blue
//        label.layer.cornerRadius = 5
//        label.layer.masksToBounds = true
//        return label
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupUI()
//    }
//    
//    private func setupUI() {
//        contentView.addSubview(label)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            label.topAnchor.constraint(equalTo: contentView.topAnchor),
//            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//        ])
//    }
//}
//
//
//import UIKit
//
//class TagViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
//
//    let tags: [String] = ["Tag 1", "Tag 2", "Tag 3", "Tag 4", "Tag 5",
//    ]
//
//    lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        layout.minimumInteritemSpacing = 8
//        layout.minimumLineSpacing = 8
//
//        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.backgroundColor = .white
//        collectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.reuseIdentifier)
//
//        return collectionView
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupCollectionView()
//    }
//
//    private func setupCollectionView() {
//        view.addSubview(collectionView)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
//            collectionView.heightAnchor.constraint(equalToConstant: 40) // Adjust the height based on your design
//        ])
//    }
//
//    // MARK: - UICollectionViewDataSource
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return tags.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.reuseIdentifier, for: indexPath) as! TagCollectionViewCell
//        cell.label.text = tags[indexPath.item]
//        return cell
//    }
//}
//
//
////#Preview {
////    ViewControllerPreview {
////        TagViewController()
////    }
////}
//
//
//#Preview {
//    ViewControllerPreview {
//        MyTagsVC()
//    }
//}
//
//class MyTagsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    var dataList:[String] = ["icon_rotate", "icon_rotate2", "icon_rotate3", "icon_rotate4", "icon_rotate5", "icon_rotate6, asdf"]
//    
//    lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
////        layout.minimumInteritemSpacing = 8
////        layout.minimumLineSpacing = 8
//
//        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.backgroundColor = .white
//        collectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.reuseIden tifier)
//
//        return collectionView
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        //other stuff
//        view.addSubview(collectionView)
//        collectionView.snp.makeConstraints { make in
//            make.centerY.equalToSuperview()
//            make.left.right.equalToSuperview()
//            make.height.equalTo(400)
//        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return (UIDevice.current.userInterfaceIdiom == .pad) ? 20.0 : 10.0
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return (UIDevice.current.userInterfaceIdiom == .pad) ? 20.0 : 10.0
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.size.height * 0.75, height: collectionView.frame.size.height * 0.75)
//    }
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return dataList.count
//    }
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCollectionViewCell
//        
//        cell.label.text = dataList[indexPath.row]
//        
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        
//        
////        let totalCellWidth = CellWidth * CellCount
////        let totalSpacingWidth = CellSpacing * (CellCount - 1)
////        let leftInset = (collectionViewWidth - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
//        
//        let totalCellWidth = 10 * dataList.count
//        let totalSpacingWidth = 10 * (dataList.count - 1)
//        let leftInset = (350 - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
//        let rightInset = leftInset
//        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
//    }
//}
