//
//  CollectionViewTest.swift
//  Test
//
//  Created by Thanh Duy on 23/08/2023.
//

import Foundation
import UIKit
import SnapKit

class CollectionViewTest: UIViewController {
    static let id = "CollectionViewTest"
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
//        layout.estimatedItemSize = CGSize(width: 1, height: 1)
        layout.itemSize = CGSize(width: 300, height: 200)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
//        collectionView.backgroundColor = .red
        collectionView.register(of: TitleCell.self)
//        collectionView.isScrollEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var testView: UIView = {
       let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationController?.title = "12312"
        self.title = "okokokosdfasdf"
        navigationController?.navigationBar.topItem?.title = "sdf"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
//        collectionView.isScrollEnabled = true
    }
}

extension CollectionViewTest: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(of: TitleCell.self, indexPath: indexPath) ?? UICollectionViewCell()
        return cell
    }
}

class TitleCell: UICollectionViewCell {
    private lazy var titleLb: UILabel = {
        let label = UILabel()
        label.text = "123123"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(titleLb)
        titleLb.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
