//
//  ResponseView.swift
//  Test
//
//  Created by Thanh Duy on 26/06/2023.
//

import Foundation
import SnapKit

class ReportNewColletionViewCell: UICollectionViewCell {
    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.text = "OK"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bugButton: ReportButtonView = {
        let button = ReportButtonView()
        button.setupView(icon: UIImage(named: "iconBug"), title: "Bug")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var feedbackButton: ReportButtonView = {
        let button = ReportButtonView()
        button.setupView(icon: UIImage(named: "iconBug"), title: "Bug")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var otherIssueButton: ReportButtonView = {
        let button = ReportButtonView()
        button.setupView(icon: UIImage(named: "iconBug"), title: "Bug")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "ok"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    private lazy var textView: InputWarningView = {
//        let inputView = InputWarningView(text: "",
//                                         inputView: textView,
//                                         handler: { [weak self] in
//                                            return !(self?.textView.isEmpty ?? true)
//        })
//        inputView.contentView?.backgroundColor = .backgroundConsumerCollectionView
//        inputView.translatesAutoresizingMaskIntoConstraints = false
//
//        return inputView
//    }()
    
    private lazy var vStack: UIStackView = {
        let vStack = UIStackView()
        vStack.backgroundColor = .cyan
        vStack.distribution = .fillEqually
        vStack.alignment = .center
        vStack.axis = .horizontal
        vStack.spacing = 16
        vStack.translatesAutoresizingMaskIntoConstraints = false
        return vStack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
        
    private func addSubViews() {
        addSubview(questionLabel)
        addSubview(vStack)
        vStack.addArrangedSubview(bugButton)
        vStack.addArrangedSubview(feedbackButton)
        vStack.addArrangedSubview(otherIssueButton)
        addSubview(separatorLine)
        addSubview(infoLabel)
    }
    
    private func addConstraints() {
        questionLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(24)
        }
        
        vStack.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(questionLabel.snp.bottom).offset(16)
//            make.height.equalToSuperview().multipliedBy(0.25)
            make.height.equalTo(100)
        }
        
        bugButton.snp.makeConstraints { make in
            make.height.equalToSuperview()
        }
        
        feedbackButton.snp.makeConstraints { make in
            make.height.equalToSuperview()
        }
        
        otherIssueButton.snp.makeConstraints { make in
            make.height.equalToSuperview()
        }
        
        separatorLine.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(1)
            make.top.equalTo(vStack.snp.bottom).offset(24)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(separatorLine.snp.bottom).offset(18)
        }
    }
}


class StackButtonViews: UIView {
    private lazy var hStack: UIStackView = {
        let hStack = UIStackView(arrangedSubviews: [bugButton, feedbackButton, otherIssueButton])
        hStack.axis = .horizontal
        hStack.spacing = 16
        hStack.distribution = .fillEqually
        hStack.alignment = .center
        hStack.backgroundColor = .gray
        hStack.translatesAutoresizingMaskIntoConstraints = false
        return hStack
    }()
    
    private lazy var bugButton: ReportButtonView = {
        let button = ReportButtonView()
        button.setupView(icon: UIImage(named: "iconBug"), title: "Bug")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var feedbackButton: ReportButtonView = {
        let button = ReportButtonView()
        button.setupView(icon: UIImage(named: "iconBug"), title: "Bug")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var otherIssueButton: ReportButtonView = {
        let button = ReportButtonView()
        button.setupView(icon: UIImage(named: "iconBug"), title: "Bug")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
        
        addSubview(hStack)
        hStack.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.3)
        }
//        
        bugButton.snp.makeConstraints { make in
//            make.height.equalToSuperview()
//            make.width.equalToSuperview().multipliedBy(103/311)
        }

        feedbackButton.snp.makeConstraints { make in
//            make.height.equalToSuperview()
//            make.width.equalToSuperview().multipliedBy(103/311)
        }

        otherIssueButton.snp.makeConstraints { make in
//            make.height.equalToSuperview()
//            make.width.equalToSuperview().multipliedBy(103/311)
        }

        
//        bugButton.snp.
//        addSubview(bugButton)
//        bugButton.snp.makeConstraints { make in
//            make.left.right.equalToSuperview()
//            make.height.equalToSuperview().multipliedBy(0.3)
//            make.centerY.equalToSuperview()
//        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

class ReportButtonView: UIView {
    var didTapAction: (() -> Void)?
        
    private lazy var iconButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = .blue
        addSubview(iconButton)
        addSubview(titleLabel)
        
        iconButton.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
//            make.width.equalToSuperview().multipliedBy(0.33)
        }
        titleLabel.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc func tapAction() {
        didTapAction?()
    }
    
    func setupView(icon: UIImage?, title: String) {
        iconButton.setImage(icon, for: .normal)
        titleLabel.text = title
    }
}

class ReportCollectionViewCell: UICollectionViewCell {
    var type: SelectedReportType? {
        didSet {
            iconButton.image = type?.reportType?.icon
            titleLabel.text = type?.reportType?.name
            iconButton.backgroundColor = type?.isActive ?? false ? .red : .gray
        }
    }
    
    private lazy var iconButton: UIImageView = {
        let view = UIImageView()
        view.contentMode = .center
        view.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(iconButton)
        addSubview(titleLabel)
        
        iconButton.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
//            make.width.equalToSuperview().multipliedBy(0.33)
        }
        titleLabel.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
//    func setupView(icon: UIImage?, title: String, isSelected: Bool?) {
//        iconButton.image = icon
//        titleLabel.text = title
//    }
}

enum ReportType {
    case bug
    case feedback
    case otherIssue
    
    var name: String {
        switch self {
        case .bug:
            return "Bao loi"
        case .feedback:
            return "Phan hoi"
        case .otherIssue:
            return "Van de khac"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .bug:
            return UIImage(named: "iconBug")
        case .feedback:
            return UIImage(named: "ic_feedback")
        case .otherIssue:
            return UIImage(named: "ic_other_issue")
        }
    }
}

class SelectedReportType: NSObject {
    var isActive: Bool = false
    var reportType: ReportType?
    init(reportType: ReportType, isActive: Bool = false) {
        self.reportType = reportType
        self.isActive = isActive
    }

    static var defaultReportType: [SelectedReportType] {
        let bug = SelectedReportType(reportType: .bug)
        let feedback = SelectedReportType(reportType: .feedback)
        let otherIssue = SelectedReportType(reportType: .otherIssue)
        return [bug, feedback, otherIssue]
    }
}


class TwoColumnCollectionViewCell: UICollectionViewCell {
    var reportTypes = SelectedReportType.defaultReportType
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        layout.scrollDirection = .horizontal
//        layout.minimumInteritemSpacing = 16
//        layout.minimumLineSpacing = 16
//        layout.estimatedItemSize = CGSize(width: 1, height: 1)

        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(of: ReportCollectionViewCell.self)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(100)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

extension TwoColumnCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reportTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(of: ReportCollectionViewCell.self, indexPath: indexPath) else { return UICollectionViewCell()}
        let type = reportTypes[indexPath.item]
        cell.type = type
        return cell
                
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        reportTypes.forEach { type in
            type.isActive = false
        }
        
        let selected = reportTypes[indexPath.row]
        selected.isActive = true
        reportTypes[indexPath.row] = selected
        
        collectionView.reloadData()
    }
}

extension TwoColumnCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width - 32) / 3
        return CGSize(width: size, height: 100)
    }
}

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(of type: T.Type = T.self,
                                indexPath: IndexPath) -> T? {
        let cell = dequeueReusableCell(
            withReuseIdentifier: NSStringFromClass(type.self),
            for: indexPath) as? T

        return cell
    }
    
    func register<T: UICollectionViewCell>(of type: T.Type = T.self) {
        register(type.self,
                 forCellWithReuseIdentifier: NSStringFromClass(type.self))
    }
}
