//
//  ColorViewController.swift
//  Test
//
//  Created by Thanh Duy on 13/11/2023.
//

import Foundation
import UIKit
import SwiftUI

class ColorViewController: UIViewController {
    private(set) lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 70, height: 70)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    private let randomColors: [UIColor] = [.red, .yellow, .blue, .orange, .purple, .systemPink, .brown]
    
    override func viewDidLoad() {
        configView()
    }
    
    private func configView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension ColorViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.contentView.backgroundColor = randomColors.randomElement()
        cell.contentView.layer.cornerRadius = 13
        return cell
    }
}

struct ColorViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            ColorViewController()
        }
    }
}
