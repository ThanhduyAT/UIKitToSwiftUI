//
//  ViewController.swift
//  Test
//
//  Created by Duy Thanh on 9/1/25.
//


import UIKit
import SwiftUI
import SnapKit

class TransitionViewController: UIViewController {
    private let largeView = UIView()
    private let newView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLargeView()
        setupNewView()
    }
    
    private func setupLargeView() {
        // Configure the large view

        largeView.backgroundColor = .systemBlue
        view.addSubview(largeView)
        largeView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.size.equalTo(300)
            make.centerX.equalToSuperview()
        }
        
        // Add a button to the large view
        let button = UIButton(type: .system)
        button.setTitle("Go to New View", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(transitionToNewView), for: .touchUpInside)
        largeView.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
    }
    
    private func setupNewView() {
        // Configure the new view
        newView.backgroundColor = .systemGreen
        newView.alpha = 0 // Hidden initially
        view.addSubview(newView)
        newView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.size.equalTo(200)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc private func transitionToNewView() {
//        UIView.animate(withDuration: 1, animations: {
//            // Fade out the large view
//            self.largeView.alpha = 0
//            // Fade in the new view
//            self.newView.alpha = 1
//            
//            self.view.layoutIfNeeded()
//        }) { _ in
//            // Hide the large view after the animation completes
//            self.largeView.isHidden = true
//        }
//        UIView.transition(with: view, duration: 3.0, options: [.curveLinear], animations: {
//            // Hide the large view and show the new view
//            self.largeView.isHidden = true
//            self.newView.alpha = 1
//            self.newView.isHidden = false
//        }) { _ in
//            print("Transition complete with a flip effect!")
//        }
        UIView.animate(withDuration: 1.0, animations: {
            // Di chuyển largeView xuống dưới
            self.largeView.transform = CGAffineTransform(translationX: self.newView.frame.maxX, y: self.newView.frame.minY).scaledBy(x: 0.1, y: 0.1)
            
            
            // Hiện newView với hiệu ứng mờ dần
            self.largeView.alpha = 0
//            self.largeView.contentScaleFactor = 0.2
            self.newView.alpha = 1
        }) { _ in
            // Ẩn largeView sau khi animation kết thúc
            self.largeView.isHidden = true
        }

//
//        UIView.transition(from: largeView,
//                          to: newView,
//                          duration: 2.0,
//                          options: [.showHideTransitionViews]) {
//            _ in
//            // This block is optional and executes when the transition is complete
//            self.largeView.isHidden = true
//            self.view.layoutIfNeeded()
//
//        }
    }
}

struct TransitionView_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            TransitionViewController()
        }
    }
}
