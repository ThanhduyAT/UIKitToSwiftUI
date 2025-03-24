//
//  TestViewController1.swift
//  Test
//
//  Created by Duy Thanh on 16/01/2024.
//

import Foundation
import SnapKit
import SwiftUI
import UIKit
import Combine


class TestStatic {
    static let shared = TestStatic()
    
    @Published var testString: String?
    
    init() {
        print("testsetset")
    }
    
    deinit {
        print("deinit vi")
    }
}

class TestViewModel1 {
    var abcString: String = "abcString"
    
    deinit {
        print("deinit viewModel")
    }
}


class TestViewController1: UIViewController {
    private let viewModel = TestViewModel1()
    
    private let testSTatic = TestStatic.shared
    private var cancellableSet: Set<AnyCancellable> = []
    
    private lazy var buttonIcon: UIButton = {
        let b = UIButton()
        b.setTitle("Test Button", for: .normal)
        b.titleLabel?.font = .systemFont(ofSize: 40)
        b.setTitleColor(.red, for: .normal)
        b.backgroundColor = .yellow
        b.addTarget(self, action: #selector(testAction), for: .touchUpInside)
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(buttonIcon)
        
        buttonIcon.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        testSTatic.$testString
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] string in
                self?.buttonIcon.setTitle(string, for: .normal)
            }.store(in: &cancellableSet)

        
        testSTatic.testString = "abc"
    }
    
    @objc func testAction() {
        navigationController?.pushViewController(TestViewController2(), animated: true)
    }
    
    deinit {
        print("deinitttt")
    }
}

class TestViewController2: UIViewController {
    private let viewModel = TestViewModel1()
    
    private let testSTatic = TestStatic.shared
    private var cancellableSet: Set<AnyCancellable> = []
    
    private lazy var textView: UILabel = {
        let l = UILabel()
        l.text = "text1234"
        l.backgroundColor = .red
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        print(viewModel.abcString)
        
        testSTatic.$testString
//            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] string in
                self?.textView.text = string
                self?.testSTatic.testString = "edf"
            }.store(in: &cancellableSet)
    }
    
    deinit {
        print("deinit deinit deinit 2")
    }
}


class ViewModel: ObservableObject { }

struct ContentView: View {
    @StateObject private var model = ViewModel()

    var body: some View {
        Button("Authenticate", action: doWork)
    }

    func doWork() {
        Task {
            for i in 1...10_000 {
                print("In Task 1: \(i)")
            }
        }

        Task {
            for i in 1...10_000 {
                print("In Task 2: \(i)")
            }
        }
    }
}


