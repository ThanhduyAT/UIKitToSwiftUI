//
//  SkeletonVC.swift
//  Test
//
//  Created by Duy Thanh on 24/07/2024.
//

import Foundation
import UIKit
import SnapKit
import SwiftUI
import Combine
import SkeletonView

class SkeletonVC: UIViewController {
    typealias ViewModel = SkeletonVM
    typealias Section = ViewModel.Section
    typealias Item = ViewModel.Item
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    
    private lazy var colletcionView: UICollectionView = makeCollectionView()
    private lazy var dataSource: DataSource = makeDataSource()
    private var cancellableSet: Set<AnyCancellable> = []
    
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SkeletonLoader.showSkeleton(for: colletcionView)
        
        setupUI()
        setupSubcriptions()
        
        colletcionView.register(SkeletonCell.self, forCellWithReuseIdentifier: "SkeletonCell")
        colletcionView.dataSource = dataSource
        
    }
    
    private func setupUI() {
        view.addSubview(colletcionView)
        colletcionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupSubcriptions() {
        viewModel.$item
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                guard let self else { return }
                var snapshot = Snapshot()
                snapshot.appendSections([.main])
                snapshot.appendItems(items, toSection: .main)
                self.dataSource.apply(snapshot, animatingDifferences: false)
//                SkeletonLoader.hideSkeleton(for: self.colletcionView)
            }
            .store(in: &cancellableSet)
    }
}

extension SkeletonVC {
    private func makeCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
//        collectionView.backgroundColor = .red
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isSkeletonable = true
        return collectionView
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    private func makeCellRegistration() -> UICollectionView.CellRegistration<SkeletonCell, Item> {
        return .init { cell, indexPath, itemIdentifier in
            let config: SkeletonCell.ContentConfig = .init(title: itemIdentifier.title, des: itemIdentifier.description)
            cell.isSkeletonable = true
            cell.contentConfiguration = config
        }
    }
    
    private func makeDataSource() -> CollectionViewSkeletonDiffableDataSource<Section, Item, SkeletonCell> {
        let cellRegistration = makeCellRegistration()
        
        let dataSource = CollectionViewSkeletonDiffableDataSource<Section, Item, SkeletonCell> (collectionView: colletcionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }
        return dataSource
    }
}

extension SkeletonVC {
    class SkeletonCell: UICollectionViewCell {
        struct ContentConfig: UIContentConfiguration, Hashable {
            let title: String
            let des: String
            
            func makeContentView() -> UIView & UIContentView {
                let view = ContentView(configuration: self)
                view.isSkeletonable = true
                return view
            }
            
            func updated(for state: UIConfigurationState) -> SkeletonVC.SkeletonCell.ContentConfig {
                return self
            }
        }
        
        class ContentView: UIView, UIContentView {
            private var appliedConfiguration: ContentConfig!
            
            var configuration: UIContentConfiguration {
                get { appliedConfiguration }
                set {
                    guard let newConfig = newValue as? ContentConfig else { return }
                    apply(configuration: newConfig)
                }
            }
            
            private lazy var containView: UIStackView = {
                let s = UIStackView(arrangedSubviews: [titleLabel, desLabel])
                s.axis = .vertical
                s.spacing = 5
                s.isSkeletonable = true
                return s
            }()
            
            private lazy var titleLabel: UILabel = {
                let l = UILabel()
                l.font = .systemFont(ofSize: 25)
                l.textColor = .red
                l.text = " "
                l.isSkeletonable = true
                return l
            }()
            
            private lazy var desLabel: UILabel = {
                let l = UILabel()
                l.font = .systemFont(ofSize: 20)
                l.textColor = .black
                l.text = " "
                l.isSkeletonable = true
                return l
            }()
            
            init(configuration: ContentConfig) {
                super.init(frame: .zero)
                setupUI()
                apply(configuration: configuration)
            }
            
            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }

            private func setupUI() {
                addSubview(containView)
                backgroundColor = .lightBlue
                containView.snp.makeConstraints { make in
                    make.left.right.bottom.top.equalToSuperview().inset(10)
                }
            }
            
            private func apply(configuration: ContentConfig) {
                guard appliedConfiguration != configuration else { return }
                appliedConfiguration = configuration
                
                titleLabel.text = configuration.title
                desLabel.text = configuration.des
            }
        }
    }
}

class CollectionViewSkeletonDiffableDataSource<Section: Hashable, Item: Hashable, T: UICollectionViewCell>: UICollectionViewDiffableDataSource<Section, Item>, SkeletonCollectionViewDataSource {

    var cellIdentifier: String =  String(describing: T.self)

    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return cellIdentifier
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, skeletonCellForItemAt indexPath: IndexPath) -> UICollectionViewCell? {
        let cell = skeletonView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        cell.isSkeletonable = true
        return cell
    }
}

public enum SkeletonLoader {
    static let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)

    public static func showSkeleton(for views: UIView...) {
        views.forEach { $0.showAnimatedGradientSkeleton(animation: animation) }
    }

    public static func hideSkeleton(for views: UIView...) {
        views.forEach { $0.hideSkeleton() }
    }
}

#Preview {
    ViewControllerPreview {
        SkeletonVC()
    }
}

//class ItemCell: UICollectionViewCell {
//    var contentConfig: ContentConfig? {
//        didSet {
//            guard let configuration = contentConfiguration else { return }
//            self.contentConfiguration = configuration
//        }
//    }
//    
//    struct ContentConfig: UIContentConfiguration, Hashable {
//        let titleText: String
//        
//        func makeContentView() -> UIView & UIContentView {
//            return ContentView(configuration: self)
//        }
//        
//        func updated(for state: UIConfigurationState) -> ContentConfig {
//            return self
//        }
//    }
//    
//    class ContentView: UIView, UIContentView {
//        private var appliedConfiguration: ContentConfig!
//        
//        var configuration: UIContentConfiguration {
//            get { appliedConfiguration }
//            set {
//                guard let newConfig = newValue as? ContentConfig else { return }
//                apply(configuration: newConfig)
//            }
//        }
//        
//        private lazy var titleLabel: UILabel = {
//            let l = UILabel()
//            l.font = .systemFont(ofSize: 15)
//            l.textColor = .red
//            l.textAlignment = .center
//            l.isSkeletonable = true
//            return l
//        }()
//        
//        init(configuration: ContentConfig) {
//            super.init(frame: .zero)
//            setupUI()
//            apply(configuration: configuration)
//        }
//        
//        required init?(coder: NSCoder) {
//            fatalError("init(coder:) has not been implemented")
//        }
//
//        private func setupUI() {
//            addSubview(titleLabel)
//            isSkeletonable = true
//            titleLabel.isSkeletonable = true
//            titleLabel.lastLineFillPercent = 30
////            backgroundColor = .lightBlue
//            titleLabel.snp.makeConstraints { make in
//                make.edges.equalToSuperview()
//                make.height.equalTo(30)
//            }
//        }
//        
//        private func apply(configuration: ContentConfig) {
//            guard appliedConfiguration != configuration else { return }
//            appliedConfiguration = configuration
//            
//            titleLabel.text = configuration.titleText
//        }
//    }
//}
//
//class DiffableDataSourceViewController: UIViewController {
//    let collectionViewLayout = UICollectionViewCompositionalLayout.list(using: .init(appearance: .plain))
//
//    lazy var collectionView: UICollectionView = {
//        return UICollectionView(frame: self.view.bounds, collectionViewLayout: collectionViewLayout)
//    }()
//
//    lazy var datasource = CollectionViewSkeletonDiffableDataSource<String, Int>(collectionView: self.collectionView) { collectionView, indexPath, item in
//        let cell = collectionView.dequeueConfiguredReusableCell(using: self.cellRegistration, for: indexPath, item: item)
//        cell.backgroundColor = UIColor(hue: CGFloat(item % 10) / 10, saturation: 0.5, brightness: 0.7, alpha: 1)
//
//        return cell
//    }
//
//    let cellRegistration = UICollectionView.CellRegistration<ItemCell, Int> { cell, IndexPath, value in
//                let config = ItemCell.ContentConfig(titleText: "\(value)")
//                cell.contentConfiguration = config
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.addSubview(collectionView)
//        collectionView.frame = view.frame
//        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: "cell")
//
//        collectionView.isSkeletonable = true
//        collectionView.dataSource = datasource
//        collectionView.showSkeleton()
//
////        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
////            var ss = NSDiffableDataSourceSnapshot<String, Int>()
////            ss.appendSections(["Section 1", "Section 2", "Section 3"])
////
////            ss.appendItems(Array((1..<10)), toSection: "Section 1")
////            ss.appendItems(Array((11..<20)), toSection: "Section 2")
////            ss.appendItems(Array((21..<30)), toSection: "Section 3")
////
////
////            self.collectionView.hideSkeleton()
////            self.datasource.apply(ss)
////        }
//    }
//}
//
//class CollectionViewSkeletonDiffableDataSource<Section: Hashable, Item: Hashable>: UICollectionViewDiffableDataSource<Section, Item>, SkeletonCollectionViewDataSource {
//
//    var cellIdentifier: String = "cell"
//
//    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
//        return cellIdentifier
//    }
//
//    func collectionSkeletonView(_ skeletonView: UICollectionView, prepareCellForSkeleton cell: UICollectionViewCell, at indexPath: IndexPath) {
////        (cell as? ItemCell)?.titleLabel.text = "XXX
//    }
//    
//    func collectionSkeletonView(_ skeletonView: UICollectionView, skeletonCellForItemAt indexPath: IndexPath) -> UICollectionViewCell? {
//        let cell = skeletonView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
//        cell.isSkeletonable = true
//        cell.contentView.isSkeletonable = true
//        return cell
//    }
//
//    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 50
//    }
//}
//
//#Preview {
//    ViewControllerPreview {
//        DiffableDataSourceViewController()
//    }
//}
