//
//  TableViewController.swift
//  Test
//
//  Created by Thanh Duy on 14/09/2023.
//

import Foundation
import UIKit
import SwiftUI
import SnapKit
import RxSwift
import RxRelay

class TableViewController: UIViewController {
    private var numberOfCells = 1
    
    private var offBlueView: CGFloat = 0
    
    private let disposed = DisposeBag()
    
    private lazy var tableView: UITableView = {
        let t = UITableView(frame: .zero, style: .plain)
        t.dataSource = self
        t.delegate = self
        t.backgroundColor = .red
        t.bounces = false
        t.contentInsetAdjustmentBehavior = .never
        t.rowHeight = UITableView.automaticDimension
        t.estimatedRowHeight = 100
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    private lazy var loadMoreView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
//        view.color = .red
        return view
    }()
    
    private lazy var headerView: UIView = {
        let v = UIView()
        v.backgroundColor = .yellow
        return v
    }()
    
    private lazy var blueView: UIView = {
        let v = UIView()
        v.backgroundColor = .blue
        v.layer.cornerRadius = 12
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var redView: UIView = {
        let v = UIView()
        v.backgroundColor = .red
        v.layer.cornerRadius = 12
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var circleView: UIView = {
        let v = UIView()
        v.backgroundColor = .black
        v.layer.cornerRadius = 0
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var emptyView: UIView = {
        let v = UIView()
        v.backgroundColor = .purple
//        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        addObservers()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}
 
extension TableViewController {
    private func setupUI() {
        view.addSubview(tableView)
        
        headerView.addSubview(blueView)
        blueView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        headerView.addSubview(redView)
        redView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(30)
            make.bottom.equalTo(blueView.snp.top).offset(-10)
        }
        
        headerView.addSubview(circleView)
        circleView.snp.makeConstraints { make in
            make.right.equalTo(redView).offset(-30)
            make.size.equalTo(24)
            make.bottom.equalTo(redView.snp.top).offset(-10)
        }
        
        tableView.stickyHeader.view = headerView
        tableView.stickyHeader.height = 300
        tableView.stickyHeader.minimumHeight = 150
        
        tableView.register(of: TabTableViewCell.self)
        tableView.register(of: CollectionViewInsideTableView.self)
        
        tableView.tableFooterView = loadMoreView
        
//        add View
//        initEmptyView(on: tableView, title: "okxe")
        tableView.addSubview(emptyView)
        emptyView.snp.makeConstraints { make in
//            make.centerX.centerY.equalToSuperview()
//            make.left.right.equalToSuperview()
            make.height.equalTo(300)
            make.centerY.equalTo(view.snp.centerY)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(100)
//            make.size.equalTo(40)
        }
    }
    
    private func addObservers() {
        tableView.rx.contentOffset.subscribe { y in
            print(y.element)
        }.disposed(by: disposed)
    }
}

extension TableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return numberOfCells
//        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(of: CollectionViewInsideTableView.self, indexPath: indexPath) else { return UITableViewCell() }
//        tableView.reloadData()
//        tableView.rowHeight = cell.collectionView.contentSize.height
        return cell
    }
}

extension TableViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
//        let offsetY = scrollView.panGestureRecognizer.translation(in: scrollView.superview).y
        let offsetY = scrollView.contentOffset.y
        
        if offsetY == -300 {
            updateBlueView(scale: 0)
        } else if offsetY > -300 && offsetY < -150 {
            var distant = 300 - abs(offsetY)
            var scale = distant / 150
//            print(scale)
            updateBlueView(scale: scale)
        } else {
            updateBlueView(scale: 1)
        }
        
//        print("pan", offsetY)
        
//        offBlueView = offsetY
//
//
        
    }
    
//    func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
//        print("changed", scrollView.contentOffset.y)
//    }
    
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        let offsetY = scrollView.contentOffset.y
//        print("begin ",offsetY)
//    }
//
//    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
//        let offsetY = scrollView.contentOffset.y
//        print("decelerating", offsetY)
//    }
//
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let offsetY = scrollView.contentOffset.y
//        print("end", offsetY)
//    }
    
    private func updateBlueView(scale: CGFloat) {
//        let scale
        let offset = scale * 30
        blueView.snp.updateConstraints { make in
            make.right.equalToSuperview().offset(-10 - offset)
        }
        
//        if scale == 1 {
//            circleView.isHidden = true
//        } else {
//            circleView.isHidden = false
//        }
    }
    
    private func initEmptyView(on tableView: UIView, title: String? = nil) {
        
        tableView.backgroundColor = .red

        let view = UIView(frame: .zero)
        tableView.addSubview(view)
        view.backgroundColor = .red
        view.centerYAnchor.constraint(equalTo: tableView.centerYAnchor).isActive = true
        view.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true

        view.translatesAutoresizingMaskIntoConstraints = false

        let img = UIImageView(image: .init(systemName: "eraser"))
        img.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(img)

        img.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        img.topAnchor.constraint(equalTo: view.topAnchor).isActive = true

        let label = UILabel(frame: .zero)
        label.text = title
        label.font = .systemFont(ofSize: 14)
        label.textColor = .blue
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        label.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 10).isActive = true
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

    }

}

struct TableViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            TableViewController()
        }
    }
}




