//
//  ScrollViewControllerTest.swift
//  Test
//
//  Created by Duy Thanh on 02/01/2024.
//

import Foundation
import UIKit
import SwiftUI
import SnapKit

class ScrollViewControllerTest: UIViewController {
    private lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = .blue
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var view1: UIView = {
        let v = UIView()
        v.backgroundColor = .red
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var view2: UIView = {
        let v = UIView()
        v.backgroundColor = .lightGray
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        view.addSubview(scrollView)
        
        let safeG = view.safeAreaLayoutGuide
        let contentG = scrollView.contentLayoutGuide
        let frameG = scrollView.frameLayoutGuide
        
        scrollView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        scrollView.addSubview(view1)
        view1.snp.makeConstraints { make in
            make.top.equalTo(contentG)
            make.height.equalTo(100)
            make.left.right.equalTo(frameG)
        }
        
        scrollView.addSubview(view2)
//        
        view2.snp.makeConstraints { make in
            make.top.equalTo(view1.snp.bottom)
            make.height.equalTo(1000)
            make.left.right.equalTo(frameG)
            make.bottom.equalTo(contentG)
        }
    }
}

struct ScrollViewControllerTest_PreviewView: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            ScrollViewControllerTest()
        }
    }
}
