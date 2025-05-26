//
//  RatingView.swift
//  Test
//
//  Created by Duy Thanh on 22/5/25.
//

import Foundation
import UIKit
import SnapKit
import SwiftUI

class RatingView: UIView {
    
    private lazy var scoreStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .center
        sv.distribution = .equalCentering
        sv.spacing = 6
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(scoreStackView)
        scoreStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        var height: CGFloat = 20
        (1...10).forEach { score in
            height += 4
            let v = makeScoreView(score: score)
            v.snp.makeConstraints { make in
                make.width.equalTo(24)
                make.height.equalTo(height)
            }
            scoreStackView.addArrangedSubview(v)
        }
    }
    
    private func makeScoreView(score: Int) -> UIView {
        let scoreView = UIView()
        scoreView.layer.cornerRadius = 16
        scoreView.layer.borderWidth = 1
        scoreView.layer.borderColor = UIColor.gray.cgColor
        scoreView.isUserInteractionEnabled = true
        scoreView.tag = score
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleStackItemTap(_:)))
        scoreView.addGestureRecognizer(tap)
        if score < 7 {
            scoreView.backgroundColor = .red
        } else if score < 9 {
            scoreView.backgroundColor = .yellow
        } else {
            scoreView.backgroundColor = .green
        }
        
        return scoreView
    }
    
    @objc private func handleStackItemTap(_ sender: UITapGestureRecognizer) {
        
        guard let tappedView = sender.view else { return }
        switch tappedView.tag {
        case 1...6:
            tappedView.backgroundColor = .systemBlue
        case 7...8:
            tappedView.backgroundColor = .systemCyan
        case 9...19:
            tappedView.backgroundColor = .lightGray
        default:
            break
        }
    }
    
    private func clearSelectedItem() {
        
    }
}

class RatingViewVC: UIViewController {
    private lazy var ratingView: RatingView = {
        let v = RatingView()
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(ratingView)
        ratingView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(100)
        }
    }
}

#Preview {
    ViewControllerPreview {
        RatingViewVC()
    }
}
