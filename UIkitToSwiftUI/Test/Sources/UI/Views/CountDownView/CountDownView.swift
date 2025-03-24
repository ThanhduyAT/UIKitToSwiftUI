
import UIKit
import SwiftUI

class CountdownView: UIView {
    private let countdownLabel: UILabel
    
    override init(frame: CGRect) {
        countdownLabel = UILabel()
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        countdownLabel = UILabel()
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        countdownLabel.translatesAutoresizingMaskIntoConstraints = false
        countdownLabel.textAlignment = .center
        countdownLabel.font = UIFont.systemFont(ofSize: 24)
        addSubview(countdownLabel)
        
        NSLayoutConstraint.activate([
            countdownLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            countdownLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func updateCountdownText(to text: String) {
        countdownLabel.text = text
    }
}

class CountdownViewController: UIViewController {
    private var countdownView: CountdownView!
    private var countdownTimer: Timer?
    private var remainingSeconds: Int = 10 // Ví dụ, 60 giây đếm ngược

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCountdownView()
        startCountdown()
    }

    private func setupCountdownView() {
        countdownView = CountdownView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        countdownView.center = view.center
        view.addSubview(countdownView)
    }

    private func startCountdown() {
        updateCountdownText()
        countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
    }

    @objc private func updateCountdown() {
        if remainingSeconds > 0 {
            remainingSeconds -= 1
            updateCountdownText()
        } else {
            countdownTimer?.invalidate()
            countdownTimer = nil
        }
    }

    private func updateCountdownText() {
        let minutes = remainingSeconds / 60
        let seconds = remainingSeconds % 60
        let countdownText = String(format: "%02d:%02d", minutes, seconds)
        countdownView.updateCountdownText(to: countdownText)
    }
}

#Preview {
    ViewControllerPreview {
        CountdownViewController()
    }
}

