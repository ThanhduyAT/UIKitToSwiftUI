//
//  CustomSegmentedControl.swift
//  Test
//
//  Created by Thanh Duy on 20/12/2022.
//

import Foundation
import UIKit
import SnapKit
import SwiftUI

class CustomSegmentedControlView: UIViewController {
    private lazy var segmentControl: SegmentControl = {
        let view = SegmentControl()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(segmentControl)
        segmentControl.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(200)
            make.height.equalTo(50)
        }
    }
}

class SegmentControl: UIView {
    let items  = ["All Fruits", "Orange", "Grapes", "Banana",  "Mango", "papaya", "coconut", "django"]
    
    let allFruits = UIButton().createSegmentedControlButton(setTitle: "All Fruits")
    let orange = UIButton().createSegmentedControlButton(setTitle: "Orange")
    let grapes = UIButton().createSegmentedControlButton(setTitle: "Grapes")

    let banana = UIButton().createSegmentedControlButton(setTitle: "Banana")
    
    let mango = UIButton().createSegmentedControlButton(setTitle: "Mango")
    
    let papaya = UIButton().createSegmentedControlButton(setTitle: "Papaya")
    
    let coconut = UIButton().createSegmentedControlButton(setTitle: "coconut")
    
    let django = UIButton().createSegmentedControlButton(setTitle: "django")
    
//    let segmentedControlBackgroundColor = UIColor.init(white: 0.1, alpha: 0.1)
    
    var selected = 2
    
    let segmentIndicator: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.red
        return v
    }()

   
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCustomSegmentedControl()
//        configureScrollableSegmentedControl()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleSegmentedControlButtons(sender: UIButton) {
        let segmentedControlButtons: [UIButton] = [
            allFruits,
            orange,
            banana,
            mango,
            papaya,
            coconut,
            django,
            grapes
        ]
        
        for button in segmentedControlButtons {
            if button == sender {
                UIView.animate(withDuration: 0.2, delay: 0.1, options: .transitionFlipFromLeft) {
                    button.backgroundColor = .white
                }

            } else {
                UIView.animate(withDuration: 0.2, delay: 0.1, options: .transitionFlipFromLeft) { [weak self] in
//                    button.backgroundColor = self?.segmentedControlBackgroundColor
                    button.backgroundColor = .gray
                }
            }
        }
    }
    
    func configureCustomSegmentedControl() {
        let separatorLine = UIView()
        separatorLine.backgroundColor = .red
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        
        let segmentedControlButtons: [UIButton] = [
            allFruits,
            orange,
            banana,
            mango,
            papaya,
            coconut,
            django,
            grapes
        ]
        
        segmentedControlButtons.forEach {
            $0.addTarget(self, action: #selector(handleSegmentedControlButtons(sender:)), for: .touchUpInside)
        }
        
        segmentedControlButtons[selected].backgroundColor = .white
        
        let stackView = UIStackView(arrangedSubviews: segmentedControlButtons)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: .zero, height: 50)
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(stackView)
        
        addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 60),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
    }
    
    func configureScrollableSegmentedControl() {
        let segmentedControl = UISegmentedControl(items: items)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: .zero, height: 50)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(segmentedControl)
        addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 50),
            
            segmentedControl.topAnchor.constraint(equalTo: scrollView.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            segmentedControl.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
}

struct Segment_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            CustomSegmentedControlView()
//            SegmentViewController()
        }
    }
}


extension UIButton {
    func createSegmentedControlButton(setTitle to: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(to, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.widthAnchor.constraint(equalToConstant: 90).isActive = true
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.backgroundColor = .gray
        button.layer.cornerRadius = 6
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }
}

