//
//  UsePageViewController.swift
//  Test
//
//  Created by Thanh Duy on 13/11/2023.
//

import Foundation
import SnapKit
import SwiftUI
import Parchment

class SegmentedControlPagingViewController: PagingViewController {
    override func loadView() {
        view = SegmentedControlPagingView(
            options: options,
            collectionView: collectionView,
            pageView: pageViewController.view
        )
    }
}

class UsePageViewController: UIViewController {
    private let items = [
        SegementedControlItem(index: 0, title: "Tab 1", icon: ""),
        SegementedControlItem(index: 1, title: "Tab 2", icon: ""),
        SegementedControlItem(index: 2, title: "Tab 3", icon: ""),
        SegementedControlItem(index: 3, title: "Tab 4", icon: "")
    ]
    
    private let viewControllers: [ColorViewController] = [
        ColorViewController(),
        ColorViewController(),
        ColorViewController(),
        ColorViewController()
    ]
    
    private let pagingViewController = PagingViewController()
    private let menuItemSize = CGSize(width: 120, height: 40)
    private let menuInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    private var menuHeight: CGFloat {
        return menuItemSize.height + menuInsets.top + menuInsets.bottom
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
        pagingViewController.view.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.centerY)
            make.left.right.bottom.equalToSuperview()
        }
//        view.constrainToEdges(pagingViewController.view)
        
        pagingViewController.register(SegmentedControlCell.self, for: SegementedControlItem.self)
        pagingViewController.menuItemSize = .sizeToFit(minWidth: menuItemSize.width, height: menuItemSize.height)
        pagingViewController.menuInsets = menuInsets
        pagingViewController.menuItemSpacing = 8
        pagingViewController.borderColor = UIColor(white: 0, alpha: 0.1)
        pagingViewController.indicatorColor = .black
        pagingViewController.backgroundColor = .red
        pagingViewController.pageViewController.scrollView.bounces = false
        
        pagingViewController.indicatorOptions = .visible(
            height: 3,
            zIndex: Int.max,
            spacing: UIEdgeInsets.zero,
            insets: UIEdgeInsets.zero
        )

        pagingViewController.borderOptions = .visible(
            height: 1,
            zIndex: Int.max - 1,
            insets: UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
        )
        
        pagingViewController.dataSource = self
        pagingViewController.delegate = self
        
        pagingViewController.reloadData()
    }
}

extension UsePageViewController: PagingViewControllerDataSource {
    func pagingViewController(_: PagingViewController, viewControllerAt index: Int) -> UIViewController {
        let viewController = viewControllers[index]
        let insets = UIEdgeInsets(top: menuHeight, left: 0, bottom: 0, right: 0)
        viewController.collectionView.contentInset = insets
        viewController.collectionView.scrollIndicatorInsets = insets
        return viewController
    }

    func pagingViewController(_: PagingViewController, pagingItemAt index: Int) -> PagingItem {
        return items[index]
    }

    func numberOfViewControllers(in _: PagingViewController) -> Int {
        return items.count
    }
}

extension UsePageViewController: PagingViewControllerDelegate {
    
}



//import Foundation
//import SnapKit
//import UIKit
//import SwiftUI
//
//class UsePageViewController: UIViewController {
//
//    private lazy var pageLabel: UILabel = {
//       let l = UILabel()
//        l.translatesAutoresizingMaskIntoConstraints = false
//        return l
//    }()
//    private lazy var segmentedControlView: CustomSegmentedContrl = {
//       let c = CustomSegmentedContrl()
//        c.backgroundColor = .white
//        c.commaSeperatedButtonTitles = "First, Two, Three"
//        c.numberOfSegments = 6
//        c.selectorColor = .red
//        c.selectorTextColor = .red
////        c.borderColor = .yellow
////        c.borderWidth = 1
////        c.isUnderLinerNeeded = false
//        c.translatesAutoresizingMaskIntoConstraints = false
//        return c
//    }()
//
//    private lazy var contentView: UIView = {
//        let v = UIView()
//        v.backgroundColor = .gray
//        v.applyShadow()
//        v.translatesAutoresizingMaskIntoConstraints = false
//        return v
//    }()
//
//    private var pageViewController: CustomPageViewController!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configView()
//    }
//
//    private func configView() {
//        view.addSubview(pageLabel)
//        pageLabel.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.centerY.equalToSuperview().multipliedBy(0.5)
//        }
//
//        view.addSubview(segmentedControlView)
//        segmentedControlView.snp.makeConstraints { make in
//            make.centerY.equalToSuperview().multipliedBy(0.2)
//            make.height.equalTo(50)
//            make.left.right.equalToSuperview()
//        }
//
//        view.addSubview(contentView)
//        contentView.snp.makeConstraints { make in
//            make.left.right.equalToSuperview()
//            make.bottom.equalToSuperview()
//            make.height.equalToSuperview().multipliedBy(0.5)
//        }
//
//        pageViewController = CustomPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
//        pageViewController.customDelegate = self
//        pageViewController.controllers = [ColorViewController(), ColorViewController(), ColorViewController()]
//        addChild(pageViewController)
//        contentView.addSubview(pageViewController.view)
//        pageViewController.view.snp.makeConstraints {
//            $0.top.leading.equalToSuperview().offset(15)
//            $0.trailing.bottom.equalToSuperview().inset(15)
//        }
//    }
//}
//
//extension UsePageViewController: CustomPageViewControllerDelegate {
//    func pageViewController(pageViewController: CustomPageViewController, didUpdatePageIndex index: Int) {
//        pageLabel.text = "Trang \(index + 1)"
//    }
//}
//
struct UsePageViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            UsePageViewController()
        }
    }
}
