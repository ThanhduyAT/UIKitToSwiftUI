//
//  ParentViewController.swift
//  Test
//
//  Created by Thanh Duy on 14/11/2023.
//

import Foundation
import Parchment
import UIKit
import SwiftUI

class VC1: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}

class ParentViewController: UIViewController {
    private var vc1 = VC1()
    var pagingViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    var viewControllers = [UIViewController]()
    
    var currentIndex = 0
    var nextIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        view.constrainToEdges(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
        
        pagingViewController.dataSource = self
        pagingViewController.delegate = self
        
        viewControllers = [
            StickHeaderViewController(),
            UsePageViewController()
        ]
        
        pagingViewController.setViewControllers([viewControllers[currentIndex]], direction: .forward, animated: true)
        
    }
}

extension ParentViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        guard let viewControllerIndex = viewControllers.firstIndex(of: viewController) else { return nil }
//
//        let previousIndex = viewControllerIndex - 1
//
//        guard previousIndex >= 0 else { return viewControllers.last }
//
//        guard viewControllers.count > previousIndex else { return nil }
//
//        return viewControllers[previousIndex]
//    
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = viewControllers.firstIndex(of: viewController) else { return nil }

        let nextIndex = viewControllerIndex + 1

        guard nextIndex < viewControllers.count else { return nil }

        guard viewControllers.count > nextIndex else { return nil }

        return viewControllers[nextIndex]
    }
}

extension ParentViewController: UIPageViewControllerDelegate {
    
    
//    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
//        if let itemController = pendingViewControllers[0] {
//            nextIndex = itemController.item
//        }
//    }
}

struct ParentViewController_PreViews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            ParentViewController()
        }
    }
}
