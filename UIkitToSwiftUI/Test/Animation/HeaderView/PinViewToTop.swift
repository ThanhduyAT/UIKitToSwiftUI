//
//  PinViewToTop.swift
//  Test
//
//  Created by Thanh Duy on 21/08/2023.
//

import Foundation
import UIKit
import SwiftUI
import SnapKit

class PinViewToTop: UIViewController {
    
    let yellowView: UIView = {
        let v = UIView()
        v.backgroundColor = .systemYellow
        return v
    }()
    let greenView: UIView = {
        let v = UIView()
        v.backgroundColor = .green
        return v
    }()
    let redView: UIView = {
        let v = UIView()
        v.backgroundColor = .systemRed
        return v
    }()
    
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = .systemBlue
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a vertical stack view
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        
        // let's add some labels to the stack view
        //  so we have something to scroll
        (1...30).forEach { n in
            let v = UILabel()
            v.backgroundColor = .yellow
            v.text = "Label \(n)"
            v.textAlignment = .center
            stack.addArrangedSubview(v)
        }
        
        // add the stack view to the red view
//        redView.addSubview(stack)
        
        // add these views to scroll view in this order
        [yellowView, redView, greenView].forEach { v in
            scrollView.addSubview(v)
        }
        
        // add scroll view to view
        view.addSubview(scrollView)
        
        // they will all use auto-layout
        [stack, yellowView, redView, greenView, scrollView].forEach { v in
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // always respect safe area
        let safeG = view.safeAreaLayoutGuide
        
        let contentG = scrollView.contentLayoutGuide
        let frameG = scrollView.frameLayoutGuide
        
        NSLayoutConstraint.activate([
            
            // constrain scroll view to safe area
            scrollView.topAnchor.constraint(equalTo: safeG.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeG.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeG.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeG.bottomAnchor),
            
            // we need yellow view to
            //  fill width of scroll view FRAME
            //  height: 100-pts
            //  "stick" to top of scroll view FRAME
            yellowView.leadingAnchor.constraint(equalTo: frameG.leadingAnchor),
            yellowView.trailingAnchor.constraint(equalTo: frameG.trailingAnchor),
            yellowView.heightAnchor.constraint(equalToConstant: 100.0),
            yellowView.topAnchor.constraint(equalTo: frameG.topAnchor),
            
            // we need green view to
            //  fill width of scroll view FRAME
            //  height: 100-pts
            //  start at bottom of yellow view
            //  "stick" to top of scroll view FRAME when scrolled up
            greenView.leadingAnchor.constraint(equalTo: frameG.leadingAnchor),
            // we'll use a constant of -40 here to leave a "gap" on the right, so it's
            //  easy to see what's happening...
            greenView.trailingAnchor.constraint(equalTo: frameG.trailingAnchor, constant: -40),
            greenView.heightAnchor.constraint(equalToConstant: 100.0),
            greenView.topAnchor.constraint(greaterThanOrEqualTo: frameG.topAnchor),
            
            // we need red view to
            //  fill width of scroll view FRAME
            //  dynamic height (determined by its contents - the stack view)
            //  start at bottom of green view
            //  "push / pull" green view when scrolled
            //  go under green view when green view is at top
            // red view will be controlling the scrollable area
            redView.leadingAnchor.constraint(equalTo: contentG.leadingAnchor),
            redView.trailingAnchor.constraint(equalTo: contentG.trailingAnchor),
            redView.bottomAnchor.constraint(equalTo: contentG.bottomAnchor),
            redView.heightAnchor.constraint(equalToConstant: 1000),
            redView.widthAnchor.constraint(equalTo: frameG.widthAnchor),
            
            // let's inset the stack view 16-pts on all 4 sides
//            stack.topAnchor.constraint(equalTo: redView.topAnchor, constant: 16.0),
//            stack.leadingAnchor.constraint(equalTo: redView.leadingAnchor, constant: 16.0),
//            stack.trailingAnchor.constraint(equalTo: redView.trailingAnchor, constant: -16.0),
//            stack.bottomAnchor.constraint(equalTo: redView.bottomAnchor, constant: -16.0),
            
        ])
        
        var c: NSLayoutConstraint!

        // these constraints need Priority adjustments

        // keep green view above red view, until green view is at top
        c = redView.topAnchor.constraint(equalTo: greenView.bottomAnchor)
        c.priority = .defaultHigh
        c.isActive = true

        // since yellow and green view Heights are constant 100-pts each
        c = redView.topAnchor.constraint(equalTo: contentG.topAnchor, constant: 200.0)
        c.isActive = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.delegate = self
    }
}

extension PinViewToTop: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        yellowView.isHidden = scrollView.contentOffset.y >= 100
        if scrollView.contentOffset.y >= 100 {
//            scrollView.snp.makeConstraints { make in
//                make.top.equalTo(greenView.snp.bottom)
//                make.left.right.bottom.equalToSuperview()
//            }
        }
    }
}

struct PinViewToTop_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            PinViewToTop()
        }
    }
}
