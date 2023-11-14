//
//  StickyView.swift
//  Test
//
//  Created by Thanh Duy on 03/09/2023.
//

import Foundation
import SnapKit
import UIKit
import SwiftUI

var topViewInitialHeight : CGFloat = 200

let topViewFinalHeight : CGFloat = UIApplication.shared.statusBarFrame.size.height + 44

let topViewHeightConstraintRange = topViewFinalHeight..<topViewInitialHeight

class StickHeaderViewController: UIViewController {
    let tabsCount = 3;
    
    private lazy var topView: UIView = {
       let v = UIView()
        v.backgroundColor = .red
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var middleCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 100, height: 50)
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(of: TabBarCollectionViewCellID.self)
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    private lazy var bottomView: UIView = {
       let v = UIView()
        v.backgroundColor = .blue
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private var pageViewController = UIPageViewController()
    private var selectedTabView = UIView()
    private var headerViewHeightConstraint: CGFloat = 200
    private var pageCollection = PageCollection()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configUI()
        populateBottomView()
        addPanGestureToTopViewAndCollectionView()
    }
    
    private func setupUI() {
        view.addSubview(topView)
        view.addSubview(middleCollectionView)
        topView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(headerViewHeightConstraint)
            make.bottom.equalTo(middleCollectionView.snp.top)
        }
        
        
        middleCollectionView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(55)
        }
        
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(middleCollectionView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func configUI() {
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 10, height: 10))
        label.text = "TAB \(1)"
        label.sizeToFit()
        var width = label.intrinsicContentSize.width
        width = width + 40
        
        selectedTabView.frame = CGRect(x: 20, y: 50, width: width, height: 5)
        selectedTabView.backgroundColor = .blue
        middleCollectionView.addSubview(selectedTabView)
        
        pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                      navigationOrientation: .horizontal,
                                                      options: nil)
        pageViewController.dataSource = self
        pageViewController.delegate = self
    }
    
    func populateBottomView() {
        
        for subTabCount in 0..<tabsCount {
            
            let tabContentVC = ContentViewController1()
            tabContentVC.innerTableViewScrollDelegate = self
            tabContentVC.numberOfCells = 30 // (subTabCount + 1) * 10
            
            let displayName = "TAB \(subTabCount + 1)"
            let page = Page(with: displayName, _vc: tabContentVC)
            pageCollection.pages.append(page)
        }
        
        let initialPage = 0
        
        pageViewController.setViewControllers([pageCollection.pages[initialPage].vc],
                                                  direction: .forward,
                                                  animated: true,
                                                  completion: nil)
        
        
        addChild(pageViewController)
        pageViewController.willMove(toParent: self)
        bottomView.addSubview(pageViewController.view)
        
        pinPagingViewControllerToBottomView()
    }
    
    func pinPagingViewControllerToBottomView() {
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        pageViewController.view.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(view.safeAreaInsets)
        }

    }
    
    func addPanGestureToTopViewAndCollectionView() {
        
        let topViewPanGesture = UIPanGestureRecognizer(target: self, action: #selector(topViewMoved))
        
        topView.isUserInteractionEnabled = true
        topView.addGestureRecognizer(topViewPanGesture)
        
        /* Adding pan gesture to collection view is overriding the collection view scroll.
         
        let collViewPanGesture = UIPanGestureRecognizer(target: self, action: #selector(topViewMoved))
        
        tabBarCollectionView.isUserInteractionEnabled = true
        tabBarCollectionView.addGestureRecognizer(collViewPanGesture)
         
        */
    }
    
    private func updateHeightHeader() {
        topView.snp.updateConstraints { make in
            make.height.equalTo(headerViewHeightConstraint)
        }
    }

    var dragInitialY: CGFloat = 0
    var dragPreviousY: CGFloat = 0
    var dragDirection: DragDirection = .Up
    
    @objc func topViewMoved(_ gesture: UIPanGestureRecognizer) {
        
        var dragYDiff : CGFloat
        
        switch gesture.state {
            
        case .began:
            
            dragInitialY = gesture.location(in: self.view).y
            dragPreviousY = dragInitialY
            print("topview",dragInitialY)
            
        case .changed:
            
            let dragCurrentY = gesture.location(in: self.view).y
            dragYDiff = dragPreviousY - dragCurrentY
            dragPreviousY = dragCurrentY
            dragDirection = dragYDiff < 0 ? .Down : .Up
            innerTableViewDidScroll(withDistance: dragYDiff)
            
        case .ended:
            
            innerTableViewScrollEnded(withScrollDirection: dragDirection)
            
        default: return
        
        }
    }
    
    func setBottomPagingView(toPageWithAtIndex index: Int, andNavigationDirection navigationDirection: UIPageViewController.NavigationDirection) {
        
        pageViewController.setViewControllers([pageCollection.pages[index].vc],
                                                  direction: navigationDirection,
                                                  animated: true,
                                                  completion: nil)
    }

    func scrollSelectedTabView(toIndexPath indexPath: IndexPath, shouldAnimate: Bool = true) {
        
        UIView.animate(withDuration: 0.3) {
            
            if let cell = self.middleCollectionView.cellForItem(at: indexPath) {
                
                self.selectedTabView.frame.size.width = cell.frame.width
                self.selectedTabView.frame.origin.x = cell.frame.origin.x
            }
        }
    }
}

extension StickHeaderViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return pageCollection.pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let tabCell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(TabBarCollectionViewCellID.self), for: indexPath) as? TabBarCollectionViewCellID {
            
            tabCell.setName = pageCollection.pages[indexPath.row].name
            return tabCell
        }
        
        return UICollectionViewCell()
    }
}

extension StickHeaderViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.item == pageCollection.selectedPageIndex {
            
            return
        }
        
        var direction: UIPageViewController.NavigationDirection
        
        if indexPath.item > pageCollection.selectedPageIndex {
            
            direction = .forward
            
        } else {
            
            direction = .reverse
        }
        
        pageCollection.selectedPageIndex = indexPath.item
        
        middleCollectionView.scrollToItem(at: indexPath,
                                          at: .centeredHorizontally,
                                          animated: true)
        
        scrollSelectedTabView(toIndexPath: indexPath)
        
        setBottomPagingView(toPageWithAtIndex: indexPath.item, andNavigationDirection: direction)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}

extension StickHeaderViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let currentViewControllerIndex = pageCollection.pages.firstIndex(where: { $0.vc == viewController }) {
            
            if (1..<pageCollection.pages.count).contains(currentViewControllerIndex) {
                
                // go to previous page in array
                
                return pageCollection.pages[currentViewControllerIndex - 1].vc
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let currentViewControllerIndex = pageCollection.pages.firstIndex(where: { $0.vc == viewController }) {
            
            if (0..<(pageCollection.pages.count - 1)).contains(currentViewControllerIndex) {
                
                // go to next page in array
                
                return pageCollection.pages[currentViewControllerIndex + 1].vc
            }
        }
        return nil
    }
}

extension StickHeaderViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard completed else { return }
        
        guard let currentVC = pageViewController.viewControllers?.first else { return }
        
        guard let currentVCIndex = pageCollection.pages.firstIndex(where: { $0.vc == currentVC }) else { return }
        
        let indexPathAtCollectionView = IndexPath(item: currentVCIndex, section: 0)
        
        scrollSelectedTabView(toIndexPath: indexPathAtCollectionView)
        middleCollectionView.scrollToItem(at: indexPathAtCollectionView,
                                          at: .centeredHorizontally,
                                          animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollView.bounces = false
    }
}

extension StickHeaderViewController: InnerTableViewScrollDelegate {
    
    var currentHeaderHeight: CGFloat {
        
        return headerViewHeightConstraint
    }
    
    func innerTableViewDidScroll(withDistance scrollDistance: CGFloat) {
       
        headerViewHeightConstraint -= scrollDistance
        /* Don't restrict the downward scroll.
 
        if headerViewHeightConstraint.constant > topViewInitialHeight {

            headerViewHeightConstraint.constant = topViewInitialHeight
        }
         
        */
        
        if headerViewHeightConstraint < topViewFinalHeight {
            
            headerViewHeightConstraint = topViewFinalHeight
        }
        updateHeightHeader()
    }
    
    func innerTableViewScrollEnded(withScrollDirection scrollDirection: DragDirection) {
        
        let topViewHeight = headerViewHeightConstraint
        
        /*
         *  Scroll is not restricted.
         *  So this check might cause the view to get stuck in the header height is greater than initial height.
 
        if topViewHeight >= topViewInitialHeight || topViewHeight <= topViewFinalHeight { return }
         
        */
        
        if topViewHeight <= topViewFinalHeight + 20 {
            
            scrollToFinalView()
            
        } else if topViewHeight <= topViewInitialHeight - 20 {
            
            switch scrollDirection {
                
            case .Down: scrollToInitialView()
            case .Up: scrollToFinalView()
            
            }
            
        } else {
            
            scrollToInitialView()
        }
    }
    
    func scrollToInitialView() {
        
        let topViewCurrentHeight = topView.frame.height
        
        let distanceToBeMoved = abs(topViewCurrentHeight - topViewInitialHeight)
        
        var time = distanceToBeMoved / 500
        
        if time < 0.25 {
            
            time = 0.25
        }
        
        headerViewHeightConstraint = topViewInitialHeight
        updateHeightHeader()
        
        UIView.animate(withDuration: TimeInterval(time), animations: {
            
            self.view.layoutIfNeeded()
        })
    }
    
    func scrollToFinalView() {
        
        let topViewCurrentHeight = topView.frame.height
        
        let distanceToBeMoved = abs(topViewCurrentHeight - topViewFinalHeight)
        
        var time = distanceToBeMoved / 500
        
        if time < 0.25 {
            
            time = 0.25
        }
        
        headerViewHeightConstraint = topViewFinalHeight
        updateHeightHeader()
        UIView.animate(withDuration: TimeInterval(time), animations: {
            
            self.view.layoutIfNeeded()
        })
    }
}

struct Page {
    
    var name = ""
    var vc = UIViewController()
    
    init(with _name: String, _vc: UIViewController) {
        
        name = _name
        vc = _vc
    }
}

struct PageCollection {
    
    var pages = [Page]()
    var selectedPageIndex = 0 //The first page is selected by default in the beginning
}

struct StickHeaderViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            StickHeaderViewController()
        }
    }
}
