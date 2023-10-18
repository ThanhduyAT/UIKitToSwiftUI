//
//  CarouselCardViewController.swift
//  Test
//
//  Created by Thanh Duy on 12/09/2023.
//

import Foundation
import UIKit
import SnapKit
import SwiftUI

class CarouselCardViewController: UIViewController {
    private var index: IndexPath = IndexPath(item: 0, section: 0)
//    private var numberOfItems: Int = 1000
//    private var numberOfItemsArray: [Int] = [1, 2, 3, 4, 5, 6]
    
    private var offsetY: CGFloat = 0
    
    private lazy var collectionView: UICollectionView = {
        let layout = UPCarouselFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sideItemScale = 0.5
        layout.sideItemShift = 50
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2, height: 400)
        layout.spacingMode = UPCarouselFlowLayoutSpacingMode.fixed(spacing: 30)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(of: CarouselCell.self)
        return collectionView
    }()
    
    var pageSize: CGSize {
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        var pageSize = layout.itemSize
        if layout.scrollDirection == .horizontal {
            pageSize.width += layout.minimumLineSpacing
        } else {
            pageSize.height += layout.minimumLineSpacing
        }
        return pageSize
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(400)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        let indexPath = IndexPath(row: numberOfItems/2, section: 0)
//        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

extension CarouselCardViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return numberOfItems
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(of: CarouselCell.self, indexPath: indexPath) else { return UICollectionViewCell()}
        
        if self.index == indexPath {
            cell.setBackground = .blue
//            cell.setOffsetY = self.offsetY
        } else {
            cell.setBackground = .red
        }
//        cell.setTitle = "\(numberOfItemsArray[indexPath.row % numberOfItemsArray.count])"
        return cell
    }
}

extension CarouselCardViewController: UICollectionViewDelegateFlowLayout {
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
//        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
//        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
////        currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
//        for cell in self.collectionView.visibleCells {
//            let indexPath = collectionView.indexPath(for: cell) ?? IndexPath(item: 0, section: 0)
//            collectionView.cellForItem(at: indexPath)?.backgroundColor = .blue
//        }
//    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        for cell in self.collectionView.visibleCells {
//            cell.backgroundColor = .blue
//        }
//        let maxOffset = scrollView.contentSize.width - collectionView.frame.size.width
//        print("max", maxOffset)
//
//        if scrollView.contentOffset.x > maxOffset {
//            collectionView.contentOffset = CGPoint(x: 0, y: scrollView.contentOffset.y)
//        }
//
//        if scrollView.contentOffset.x < 0 {
////            collectionView.contentOffset = CGPoint(x: -scrollView.contentInset.right, y: scrollView.contentOffset.y)
//
//            let indexPath = IndexPath(row: 4, section: 0)
//            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//        }
        
        
        let offsetX = scrollView.contentOffset.x
        findCenterIndex()
        self.offsetY = offsetX
        self.collectionView.reloadData()
    }
    
    private func findCenterIndex() {
        let center = self.view.convert(self.collectionView.center, to: self.collectionView)
        if let index = collectionView.indexPathForItem(at: center) {
            self.index = index
        } else {
            print(index ?? "index not found")
        }
    }
}

class CarouselCell: UICollectionViewCell {
    var setBackground: UIColor? {
        didSet {
            guard let setBackground = setBackground else { return }
            contentView.backgroundColor = setBackground
        }
    }
    
    var setTitle: String = "1" {
        didSet {
            textLabel.text = setTitle
        }
    }
    
    var setOffsetY: CGFloat = 0 {
        didSet {
            updateContentCenter(setOffsetY)
        }
    }
    
    private lazy var viewWhite: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var textLabel: UILabel = {
        let v = UILabel()
        v.font = .systemFont(ofSize: 30)
        v.text = "2123123"
        v.textColor = .red
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .red
        contentView.addSubview(viewWhite)
        viewWhite.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(30)
        }
        
        contentView.addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.bottom.equalTo(viewWhite.snp.top)
            make.centerX.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func updateContentCenter(_ offsetY: CGFloat) {
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.viewWhite.snp.updateConstraints { make in
                make.centerY.equalToSuperview().offset(offsetY)
            }
        }
    }
}

struct CarouselCardViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            CarouselCardViewController()
        }
    }
}

