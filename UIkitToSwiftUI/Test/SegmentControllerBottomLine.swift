//
//  SegmentControllerBottomLine.swift
//  Test
//
//  Created by Thanh Duy on 04/07/2023.
//

import Foundation
import UIKit
import SnapKit
import SwiftUI

class CustomSegmentedControlNewView: UIViewController {
    private lazy var segmentControl: SegmentControlBottomLineView = {
        let view = SegmentControlBottomLineView()
        view.backgroundColor = .red
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(segmentControl)
        segmentControl.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(70)
        }
    }
}


class SegmentControlCell: UIView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        addSubview(separatorLine)
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(5)
            make.centerY.equalToSuperview()
        }
        
        separatorLine.snp.updateConstraints { make in
            make.bottom.equalToSuperview().offset(4)
            make.height.equalTo(2)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setTitle(title: String) {
        titleLabel.text = title
        
        if title == "Orange" {
            snp.makeConstraints { make in
                make.width.equalTo(300)
            }
        }
    }
    
    func setSeparatorColor(isVisible: Bool) {
        if isVisible {
            separatorLine.backgroundColor = .red
            separatorLine.transform = CGAffineTransform.identity
        } else {
            separatorLine.backgroundColor = .white
            separatorLine.transform = CGAffineTransform.identity
        }
    }
}

class SegmentControlBottomLineView: UIView {
    let item =  ["All Fruits", "Orange", "All Fruits", "All Fruits"]
    var segmentControlCells: [SegmentControlCell] = []
    var selected = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        segmentControlCells = item.enumerated().map({ index, title in
            let segmentControlCell = SegmentControlCell()
            segmentControlCell.setTitle(title: title)
            segmentControlCell.tag = index
            //            if title == "Orange" {
            //                segmentControlCell.widthAnchor.constraint(equalToConstant: 100).isActive = true
            //
            //            }
            return segmentControlCell
        })
        
        configureCustomSegmentedControl()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureCustomSegmentedControl() {
        segmentControlCells.forEach {
            $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSegmentedControlButtons(sender:))))
        }
        
//        segmentControlCells[selected].backgroundColor = .gray
        segmentControlCells[selected].setSeparatorColor(isVisible: true)
        
        let stackView = UIStackView(arrangedSubviews: segmentControlCells)
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        //        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: .zero, height: 50)
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(60)
            make.centerY.equalToSuperview()
        }
        
        scrollView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
            make.centerY.equalToSuperview()
        }
    }
    
    @objc func handleSegmentedControlButtons(sender: UIGestureRecognizer) {
        for cell in segmentControlCells {
            if cell.tag == sender.view?.tag {
                UIView.animate(withDuration: 1, delay: 0.1, options: .transitionCrossDissolve) {
//                    cell.backgroundColor = .gray
                    cell.setSeparatorColor(isVisible: true)
                    self.layoutIfNeeded()
                }
                
            } else {
                UIView.animate(withDuration: 1, delay: 0.1, options: .transitionCrossDissolve) {
                    //                    button.backgroundColor = self?.segmentedControlBackgroundColor
//                    cell.backgroundColor = .white
                    cell.setSeparatorColor(isVisible: false)
                    self.layoutIfNeeded()
                }
            }
            
        }
    }
    
}

struct SegmentCell_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            CustomSegmentedControlNewView()
        }
    }
}

