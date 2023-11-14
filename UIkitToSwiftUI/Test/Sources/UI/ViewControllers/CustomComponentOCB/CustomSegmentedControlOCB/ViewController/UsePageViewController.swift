//
//  UsePageViewController.swift
//  Test
//
//  Created by Thanh Duy on 13/11/2023.
//

import Foundation
import SnapKit
import SwiftUI




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
//struct UsePageViewController_Previews: PreviewProvider {
//    static var previews: some View {
//        ViewControllerPreview {
//            UsePageViewController()
//        }
//    }
//}
