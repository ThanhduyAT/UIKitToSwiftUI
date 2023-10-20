//
//  StickyHeaderCollectionViewController.swift
//  Test
//
//  Created by Thanh Duy on 30/08/2023.
//

import Foundation
import SnapKit
import UIKit
import SwiftUI

class StickyHeaderCollectionViewController: UIViewController {
    
    // MARK: - Properties
    
    fileprivate let CellIdentifier = "Cell"
    fileprivate let HeaderIdentifier = "Header"
    
    private lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
        let layout = StickyHeaderCollectionViewFlowLayout()
//        layout.sectionHeadersPinToVisibleBounds = true
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: CellIdentifier)
        collectionView.register(StickyHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NSStringFromClass(StickyHeader.self))
        collectionView.register(HeaderTest.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NSStringFromClass(HeaderTest.self))
        return collectionView
    }()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - View Methods

    private func setupCollectionView() {
        // Add as Subview
        view.addSubview(collectionView)

        // Add Constraints
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

extension StickyHeaderCollectionViewController: UICollectionViewDataSource {

    // MARK: - Collection View Data Source Methods

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(arc4random_uniform(10) + 2)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Dequeue Reusable Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier, for: indexPath)

        // Configure Cell
        cell.backgroundColor = UIColor(red:0.2, green:0.25, blue:0.3, alpha:1.0)
        cell.contentView.backgroundColor = UIColor(red:0.2, green:0.25, blue:0.3, alpha:1.0)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // Dequeue Reusable Supplementary View
        if indexPath.section == 1 {
            if let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NSStringFromClass(HeaderTest.self), for: indexPath) as? HeaderTest {
                // Configure Supplementary View
                supplementaryView.setTitle = "Section \(indexPath.section)"
                
                return supplementaryView
            }
            fatalError("Unable to Dequeue Reusable Supplementary View")
        } else {
            if let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NSStringFromClass(StickyHeader.self), for: indexPath) as? StickyHeader {
                // Configure Supplementary View
                supplementaryView.backgroundColor = .random()
                supplementaryView.setTitle = "Section \(indexPath.section)"
                
                return supplementaryView
            }
            fatalError("Unable to Dequeue Reusable Supplementary View")
        }

        
    }

}

extension StickyHeaderCollectionViewController {
    func isHeader(headerView: UIView, onTopOfCollectionView collectionView: UICollectionView) -> Bool {
        guard let collectionSuperView = collectionView.superview else {
             return false // Collection view is not in view hierarchy. This will most likely never happen
        }
        let convertedFrame = headerView.convert(headerView.bounds, to: collectionSuperView) // Convert frame of the view to whatever is the superview of collection view
        return convertedFrame.origin.y <= collectionView.frame.origin.y // Compare frame origins
    }
}

extension StickyHeaderCollectionViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    // MARK: - Collection View Delegate Flow Layout Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 44.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 1 {
            return CGSize(width: collectionView.bounds.width, height: 200)
        }
        return CGSize(width: collectionView.bounds.width, height: 80.0)
    }

}

extension StickyHeaderCollectionViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionView.visibleSupplementaryViews(ofKind: UICollectionView.elementKindSectionHeader).forEach { view in
            if let header = view as? HeaderTest {
//                header = isHeader(headerView: header, onTopOfCollectionView: <#T##UICollectionView#>)
            }
        }
    }
}

struct StickyHeaderCollectionViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            StickyHeaderCollectionViewController()
        }
    }
}
