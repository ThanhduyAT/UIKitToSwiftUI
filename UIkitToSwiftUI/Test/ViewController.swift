//
//  ViewController.swift
//  Test
//
//  Created by Thanh Duy on 02/11/2022.
//

import UIKit
import AMPopTip
import SnapKit

class ViewController: UIViewController {
    let popTip = PopTip()
    var direction = PopTipDirection.up
    var topRightDirection = PopTipDirection.down
    var timer: Timer? = nil
    var autolayoutView: UIView?
    
    private lazy var testView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 100, width: 100, height: 200))
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var TestButton: UIButton = {
        let button = UIButton()
        button.setTitle("test", for: .normal)
        button.titleLabel?.textColor = .red
        button.backgroundColor = .blue
       return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        view.addSubview(testView)
        
        testView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.width.equalTo(100)
        }
    }
    
    @IBAction func testAction(_ sender: UIButton!) {
        let customView = OptionView(frame: CGRect(x: view.frame.origin.x, y: 0, width: 165, height: 135))
        popTip.bubbleColor = .gray
        popTip.bubbleOffset = 16
        popTip.borderColor = .gray
        popTip.show(customView: customView, direction: .up, in: view, from: sender.frame)
    }
}



import SnapKit
import UIKit

class OptionView: UIView {
    var didTapGoHome:(() -> Void)?
    var didTapGoFavorites:(() -> Void)?
    var didTapShare:(() -> Void)?
    
    private lazy var goHomeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Về trang chủ", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(goHomeAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var topLineView : UIView = {
        let view  = UIView(frame: .zero)
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.red.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var goFavoritesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Đến mục yêu thích", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(goFavoritesAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var bottomLineView : UIView = {
        let view  = UIView(frame: .zero)
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.red.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setTitle("Chia sẻ", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(shareAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        addConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addViews() {
        addSubview(goHomeButton)
        addSubview(goFavoritesButton)
        addSubview(shareButton)
        addSubview(topLineView)
        addSubview(bottomLineView)
    }
    
    private func addConstraint() {
        goHomeButton.snp.makeConstraints { make in
            make.top.equalTo(4)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.width.equalTo(141)
            make.height.equalTo(40)
        }
        topLineView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(3)
            make.top.equalTo(goHomeButton.snp.bottom)
        }
        goFavoritesButton.snp.makeConstraints { make in
            make.width.height.left.right.equalTo(goHomeButton)
            make.top.equalTo(topLineView.snp.bottom)
        }
        bottomLineView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(141)
            make.height.equalTo(3)
            make.top.equalTo(goFavoritesButton.snp.bottom)
        }
        shareButton.snp.makeConstraints { make in
            make.width.height.left.right.equalTo(goHomeButton)
            make.top.equalTo(bottomLineView.snp.bottom)
        }
    }
    
    @objc private func goHomeAction() {
        self.didTapGoHome?()
    }
    
    @objc private func goFavoritesAction() {
        self.didTapShare?()
    }
    
    @objc private func shareAction() {
        self.didTapShare?()
    }
}
//


import UIKit
import SwiftUI

struct ViewControllerPreview: UIViewControllerRepresentable {
    let viewControllerBuilder: () -> UIViewController

    init(_ viewControllerBuilder: @escaping () -> UIViewController) {
        self.viewControllerBuilder = viewControllerBuilder
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return viewControllerBuilder()
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // Not needed
    }
}

struct ViewPreview: UIViewRepresentable {
    let viewBuilder: () -> UIView
    
    init(viewBuilder: @escaping () -> UIView) {
        self.viewBuilder = viewBuilder
    }
    
    func makeUIView(context: Context) -> some UIView {
        return viewBuilder()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

final class PreviewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let image = UIImage(systemName: "play.circle.fill")
        let imageView = UIImageView(image: image!)
        view.addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
}



class InputTest: UIView {
    private lazy var inputWarningView: InputWarningView = {
        let view = InputWarningView()
        view.backgroundColor = .red
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(inputWarningView)
        inputWarningView.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(100)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

class ButtonView: UIView {
    private lazy var buttonImage: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitle("123", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        button.tintColor = .yellow
        button.semanticContentAttribute = .forceRightToLeft
//        button.imageEdgeInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(buttonImage)
        buttonImage.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(100)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class InputWarningView: UIView {
    private var spaceConstraint: NSLayoutConstraint?
    var contentView: UIView?
    private var checkValidHandler: (() -> Bool)?

    private lazy var warningLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .red
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var checkUserIDLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private var leadingConstraint: NSLayoutConstraint?

    var isValid: Bool {
        return checkValidHandler?() ?? true
    }

    var stringValue: String? {
        guard let textField = contentView as? UITextField else { return nil }
        return textField.text ?? textField.attributedText?.string
    }

    var warningMessage: String? {
        didSet {
            warningLabel.text = warningMessage
        }
    }

    var textField: UITextField? {
        guard let textField = contentView as? UITextField else { return nil }
        return textField
    }

    convenience init(text: String, inputView: UIView, handler: (() -> Bool)? = nil) {
        self.init(frame: .zero)

        self.contentView = inputView
        self.checkValidHandler = handler

        inputView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(inputView)

        inputView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        inputView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        inputView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        addSubview(checkUserIDLabel)
        checkUserIDLabel.isHidden = true
        leadingConstraint = checkUserIDLabel.leadingAnchor.constraint(equalTo: inputView.leadingAnchor)
        checkUserIDLabel.centerYAnchor.constraint(equalTo: inputView.centerYAnchor).isActive = true

        leadingConstraint?.isActive = true

        warningLabel.text = text
        addSubview(warningLabel)

        warningLabel.isHidden = true
        warningLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        warningLabel.topAnchor.constraint(equalTo: inputView.bottomAnchor, constant: 5).isActive = true

        let offset = textField?.leftView?.frame.width ?? 0
        warningLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: offset).isActive = true
        warningLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        warningLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true

        textField?.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
    }

    override public var isUserInteractionEnabled: Bool {
        didSet {
            contentView?.isUserInteractionEnabled = isUserInteractionEnabled
        }
    }

    func showWarning(updateText: String? = nil) {
        if let text = updateText {
            warningLabel.text = text
        }
        warningLabel.isHidden = false
        spaceConstraint?.constant = 30
    }

    func hideWarning() {
        warningLabel.isHidden = true
        spaceConstraint?.constant = 0
    }

    func appendCheck(text: String, color: UIColor?) {
        guard let textField = contentView as? UITextField else { return }

        guard let currentTxt = stringValue, !currentTxt.isEmpty else { return }

        checkUserIDLabel.text = text
        checkUserIDLabel.textColor = color
        checkUserIDLabel.isHidden = false

//        let offset = currentTxt.width(with: textField.frame.height,
//                                      font: UIFont.systemFont(ofSize: 14)
//        leadingConstraint?.constant = offset + (textField.leftView?.frame.width ?? 0) + 10
    }

    var placeHolder: String? {
        didSet {
            guard let textField = contentView as? UITextField else { return }
            textField.placeholder = placeHolder
        }
    }

    var text: String? {
        didSet {
            guard let textField = contentView as? UITextField else { return }
            textField.text = text
        }
    }

    @objc private func textFieldDidChanged() {
        checkUserIDLabel.isHidden = true
    }
}

extension String {
    func height(with width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [.font: font],
                                            context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(with height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [.font: font],
                                            context: nil)
        
        return ceil(boundingBox.width)
    }
}


class ShadowView: UIView {
    private lazy var shadow: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.shadowColor = UIColor.blue.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: -6.0)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 2
        view.layer.masksToBounds = false
//        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
//        view.layer.rasterizationScale = UIScreen.main.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(shadow)
        shadow.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

class DashedCircleView: UIView {

    private var shapeLayer: CAShapeLayer = {
            let shapeLayer = CAShapeLayer()
            shapeLayer.strokeColor = #colorLiteral(red: 0.00187793409, green: 0.8000455499, blue: 0.811660111, alpha: 1)
            shapeLayer.fillColor = #colorLiteral(red: 0.00187793409, green: 0.8000455499, blue: 0.811660111, alpha: 1)
            shapeLayer.lineWidth = 1
            shapeLayer.lineCap = .square
            return shapeLayer
        }()

        override init(frame: CGRect = .zero) {
            super.init(frame: frame)
            configure()
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            configure()
        }

        override func layoutSubviews() {
            super.layoutSubviews()
            updatePath()
        }
    }

    private extension DashedCircleView {
        func configure() {
            layer.addSublayer(shapeLayer)
        }

        func updatePath() {
            let rect = bounds.insetBy(dx: shapeLayer.lineWidth / 2, dy: shapeLayer.lineWidth / 2)
            let radius = min(rect.width, rect.height) / 2
            let center = CGPoint(x: rect.midX, y: rect.midY)

            let path = UIBezierPath()
            let count = 60
            let relativeDashLength: CGFloat = 0.25 // a value between 0 and 1
            let increment: CGFloat = .pi * 2 / CGFloat(count)

            for i in 0 ..< count {
                let startAngle = increment * CGFloat(i)
                let endAngle = startAngle + relativeDashLength * increment
                path.move(to: CGPoint(x: center.x + radius * cos(startAngle),
                                      y: center.y + radius * sin(startAngle)))
                path.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            }
            shapeLayer.path = path.cgPath
        }
}

