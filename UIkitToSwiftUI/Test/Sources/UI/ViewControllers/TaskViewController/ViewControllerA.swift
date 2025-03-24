//
//  ViewControllerA.swift
//  Test
//
//  Created by Duy Thanh on 13/3/25.
//


import UIKit
import SnapKit
import Combine

class TaskViewControllerA: UIViewController {
    private lazy var button: UIButton = {
        let b = UIButton()
        b.setTitle("Test", for: .normal)
        b.backgroundColor = .red
        b.addAction(UIAction(handler: { [weak self] _ in
            guard let self else { return }
            let vc = TaskViewControllerB()
            self.navigationController?.pushViewController(vc, animated: true)
        }), for: .touchUpInside)
        return b
    }()
    
    override func viewDidLoad() {
        
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(40)
        }
    }
}

class TaskViewModelB {
    @Published var state: State = .loading
    private var apiTask: Task<Void, Never>?
    
    deinit {
        print("TaskViewModelB deinit")
    }

    func loadData() {
        state = .loading
        apiTask = Task {
            do {
                let result = try await fetchData()
                print("done")
                state = .success
            } catch is CancellationError {
                print("cancel")
            } catch {
//                guard !Task.isCancelled else {
//                    print("cancel error")
//                    return
//                }
                print("error")
                state = .fail
            }
        }
    }

    private func fetchData() async throws -> String {
        try await Task.sleep(nanoseconds: 5_000_000_000) // Giả lập API call 3 giây
//        try Task.checkCancellation()
        return "API Response"
    }
    
    enum State {
        case loading
        case success
        case fail
    }
}

class TaskViewControllerB: UIViewController {
    let viewModel = TaskViewModelB()
    private var cancellableSet: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadData()
    }
    
    func subscriptions() {
        viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self else { return }
                switch state {
                case .loading:
                    break
                case .success:
                    showPopup(message: "Success")
                case .fail:
                    showPopup(message: "Fail")
                }
            }
            .store(in: &cancellableSet)
        
    }

    private func showPopup(message: String) {
        guard presentedViewController == nil else { return } // Kiểm tra tránh lặp popup
        let alert = UIAlertController(title: "Info", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
//        apiTask?.cancel()
        super.viewDidDisappear(animated)
    }

    deinit {
//        apiTask?.cancel() // Hủy Task khi ViewController bị giải phóng
        print("ViewControllerB deinit")
    }
}
