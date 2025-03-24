import UIKit
import SkeletonView
import SwiftUI

class ItemCell: UICollectionViewCell {
    let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])

        isSkeletonable = true
        contentView.isSkeletonable = true
        titleLabel.isSkeletonable = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DiffableDataSourceViewController: UIViewController {
    let collectionViewLayout = UICollectionViewCompositionalLayout.list(using: .init(appearance: .plain))

    lazy var collectionView: UICollectionView = {
        return UICollectionView(frame: self.view.bounds, collectionViewLayout: collectionViewLayout)
    }()

    lazy var datasource = CollectionViewSkeletonExampleDiffableDataSource<String, Int>(collectionView: self.collectionView) { collectionView, indexPath, item in
        let cell = collectionView.dequeueConfiguredReusableCell(using: self.cellRegistration, for: indexPath, item: item)
        cell.backgroundColor = UIColor(hue: CGFloat(item % 10) / 10, saturation: 0.5, brightness: 0.7, alpha: 1)

        return cell
    }

    let cellRegistration = UICollectionView.CellRegistration<ItemCell, Int> { cell, IndexPath, value in
        cell.titleLabel.text = String(value)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)
        collectionView.frame = view.frame
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: "cell")

        collectionView.isSkeletonable = true
        collectionView.dataSource = datasource
        collectionView.showSkeleton()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            var ss = NSDiffableDataSourceSnapshot<String, Int>()
            ss.appendSections(["Section 1", "Section 2", "Section 3"])

            ss.appendItems(Array((1..<10)), toSection: "Section 1")
            ss.appendItems(Array((11..<20)), toSection: "Section 2")
            ss.appendItems(Array((21..<30)), toSection: "Section 3")


            self.collectionView.hideSkeleton()
            self.datasource.apply(ss)
        }
    }
}

class CollectionViewSkeletonExampleDiffableDataSource<Section: Hashable, Item: Hashable>: UICollectionViewDiffableDataSource<Section, Item>, SkeletonCollectionViewDataSource {

    var cellIdentifier: String = "cell"

    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return cellIdentifier
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, prepareCellForSkeleton cell: UICollectionViewCell, at indexPath: IndexPath) {
        (cell as? ItemCell)?.titleLabel.text = "XXX"
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
}

#Preview {
    ViewControllerPreview {
        DiffableDataSourceViewController()
    }
}
