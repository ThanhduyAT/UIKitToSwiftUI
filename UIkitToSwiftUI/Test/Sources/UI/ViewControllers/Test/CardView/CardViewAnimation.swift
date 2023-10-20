//
//  CardViewAnimation.swift
//  Test
//
//  Created by Thanh Duy on 07/09/2023.
//

import Foundation
import UIKit
import SwiftUI
import SnapKit

class CardViewAnimation: UIViewController {
    private lazy var cardView: UICollectionView = {
        let layout = CardPagingLayout()
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.register(of: CardCell.self)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(cardView)
        cardView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(300)
        }
    }
}

extension CardViewAnimation: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(of: CardCell.self, indexPath: indexPath) else { return UICollectionViewCell() }
        cell.backgroundColor = UIColor.random()
        return cell
    }
}

extension CardViewAnimation: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
}



class CardCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

struct CardViewAnimation_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            CardViewAnimation()
        }
    }
}

