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
        dataSource = self
        delegate = self
        if let initialViewController = controllers.first {
            scrollToViewController(viewController: initialViewController)
        }
        
//        for subview in self.view.subviews {
//            if let scrollView = subview as? UIScrollView {
//                scrollView.delegate = self
//                break
//            }
//        }
    }
    
    func scrollToViewController(index newIndex: Int) {
        if let firstViewController = viewControllers?.first,
           let currentIndex = controllers.firstIndex(of: firstViewController) {
            let direction: UIPageViewController.NavigationDirection = newIndex >= currentIndex ? .forward : .reverse
            let nextViewController = controllers[newIndex]
            scrollToViewController(viewController: nextViewController, direction: direction)
        }
    }
    
    
    private func notifyTutorialDelegateOfNewIndex() {
        if let firstViewController = viewControllers?.first,
           let index = controllers.firstIndex(of: firstViewController) {
            customDelegate?.pageViewController(pageViewController: self, didUpdatePageIndex: index)
        }
    }
    
    private func scrollToViewController(viewController: UIViewController,
                                        direction: UIPageViewController.NavigationDirection = .forward) {
        setViewControllers([viewController],
                           direction: direction,
                           animated: true,
                           completion: { _ in
                            self.notifyTutorialDelegateOfNewIndex()
                           })
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

extension CustomPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let controllerIndex = controllers.firstIndex(of: viewController) else {
            return nil
        }
        let previousIndex = controllerIndex - 1
        if previousIndex >= 0 {
            return controllers[previousIndex]
        }
        return nil
    }

    func pageViewController(_: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let controllerIndex = controllers.firstIndex(of: viewController) else {
            return nil
        }
        let nextIndex = controllerIndex + 1
        if nextIndex < controllers.count {
            return controllers[nextIndex]
        }
        return nil
    }
}

extension CustomPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_: UIPageViewController,
                            didFinishAnimating _: Bool,
                            previousViewControllers _: [UIViewController],
                            transitionCompleted _: Bool) {
        notifyTutorialDelegateOfNewIndex()
    }
}
