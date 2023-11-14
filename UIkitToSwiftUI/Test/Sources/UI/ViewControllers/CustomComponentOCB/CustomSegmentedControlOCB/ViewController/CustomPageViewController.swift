//
//  CustomPageViewController.swift
//  Test
//
//  Created by Thanh Duy on 13/11/2023.
//

import Foundation
import UIKit
import SwiftUI

protocol CustomPageViewControllerDelegate: AnyObject {
    func pageViewController(pageViewController: CustomPageViewController, didUpdatePageIndex index: Int)
}

class CustomPageViewController: UIPageViewController {
    weak var customDelegate: CustomPageViewControllerDelegate?
    var controllers = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        scrollView.bounces = false
//    }
}

//extension CustomPageViewController: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if (currentPage == 0 && scrollView.contentOffset.x < scrollView.bounds.size.width) {
//            scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0);
//        } else if (currentPage == totalViewControllersInPageController - 1 && scrollView.contentOffset.x > scrollView.bounds.size.width) {
//            scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0);
//        }
//    }
//
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        if (currentPage == 0 && scrollView.contentOffset.x <= scrollView.bounds.size.width) {
//            targetContentOffset.pointee = CGPoint(x: scrollView.bounds.size.width, y: 0);
//        } else if (currentPage == totalViewControllersInPageController - 1 && scrollView.contentOffset.x >= scrollView.bounds.size.width) {
//            targetContentOffset.pointee = CGPoint(x: scrollView.bounds.size.width, y: 0);
//        }
//    }
//}
