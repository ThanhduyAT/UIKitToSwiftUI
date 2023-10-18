//
//  ScrollView.swift
//  Test
//
//  Created by Thanh Duy on 14/12/2022.
//

import Foundation
import SnapKit
import UIKit
import SwiftUI

class TestViewSS: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

class ScrollViewController: UIViewController {
    private lazy var scrollView: ScrollView = {
        let view = ScrollView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
}

class ScrollView: UIView {
    let items = ["Black", "Red", "Blue", "white"]
        
    private lazy var scrollViewHorizontal: UIScrollView = {
        let view = UIScrollView()
        view.contentSize = CGSize(width: .zero, height: 80)
//        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "asdfsdf"
        label.font = .systemFont(ofSize: 20)
        label.textColor = .red
        return label
    }()
    
    private lazy var segmentedControl: SegmentControlView = {
        let control = SegmentControlView(items: items)
        return control
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        addConstraints()
        
        
        self.segmentedControl.setWidth(UIScreen.main.bounds.width / 6, forSegmentAt: 0)
        self.segmentedControl.setWidth(UIScreen.main.bounds.width / 3, forSegmentAt: 1)
        self.segmentedControl.setWidth(UIScreen.main.bounds.width / 3, forSegmentAt: 2)
        self.segmentedControl.setWidth(UIScreen.main.bounds.width / 3, forSegmentAt: 3)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func addViews() {
//        addSubview(scrollView)
        addSubview(titleLabel)
        addSubview(scrollViewHorizontal)
        scrollViewHorizontal.addSubview(segmentedControl)
//        scrollViewHorizontal.insertSubview(segmentedControl, aboveSubview: scrollViewHorizontal)
    }
    
    private func addConstraints() {
//        scrollView.snp.makeConstraints { make in
//            make.left.right.top.bottom.equalToSuperview()
//        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
        }
        
        scrollViewHorizontal.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(80)
        }
//        segmentedControl.snp.makeConstraints { make in
//            make.left.right.equalToSuperview()
//            make.centerY.equalToSuperview()
//            make.height.equalTo(40)
//        }
    }
}

class SegmentControlView: UISegmentedControl {
    private lazy var separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(separatorLine)
        separatorLine.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(3)
            make.height.equalTo(1)
        }
    
        backgroundColor = .red
        selectedSegmentIndex = 0
        selectedSegmentTintColor = .red
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override init(items: [Any]?) {
        super.init(items: items)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
}

struct Scroll_Previews: PreviewProvider {
    static var previews: some View {
//        ViewControllerPreview {
        ViewPreview {
            //            ShadowView()
            ScrollView()
            //        }.frame(width: 200, height: 200, alignment: .center)
        }
    }
}


