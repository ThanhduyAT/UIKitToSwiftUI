import Foundation
import UIKit

class TestThreadVC: UIViewController {
    private lazy var label1: UILabel = {
        let l = UILabel()
        l.text = "adfsaf"
        return l
    }()
    
    private lazy var label2: UILabel = {
        let l = UILabel()
        l.text = "adfsaf"
        return l
    }()
    
    private lazy var stackView: UIStackView = {
        let l = UIStackView(arrangedSubviews: [label1, label2])
        l.axis = .vertical
        l.spacing = 10
        l.backgroundColor = .red
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        
        print("abcdef")
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(300)
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: { [weak self] in
            self?.label2.text = "test thwur xme naof aweasd"
        })
//        testThread()
        
        
    }
    
    private func testThread() {
        Task(priority: .utility) {
            print("test2 task", Thread.isMainThread) // true
            print("test2 task", Thread.current) // true
        }
        
        Task.detached {
            print("detached task", Thread.isMainThread) // true
            print("detached task", Thread.current) // true
        }
        
        Task(priority: .low) {
            print("low task", Thread.isMainThread) // true
            print("low task", Thread.current) // true
        }
        
        Task(priority: .high) {
            print("high task", Thread.isMainThread) // true
            print("high task", Thread.current) // true
        }
        
        Task(priority: .medium) {
            print("medium task", Thread.isMainThread) // true
            print("medium task", Thread.current) // true
        }
        
        Task(priority: .userInitiated) {
            print("test2 task", Thread.isMainThread) // true
            print("test2 task", Thread.current) // true
        }
        
        Task {
            print("task", Thread.isMainThread) // true
            print("task", Thread.current) // true
        }
        
        Task { @MainActor in
            print("MainActor task", Thread.isMainThread)
            print("MainActor task", Thread.current)
        }
    }
}
