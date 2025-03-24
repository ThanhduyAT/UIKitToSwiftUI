//
//  TooltipView.swift
//  Test
//
//  Created by Duy Thanh on 7/1/25.
//

import SwiftUI
import UIKit
import SnapKit

public class TooltipView: UIView {
    public enum Position {
        case top
        case bottom
        case right
        case left
    }
    
    public struct ArrowConfig {
        let size: CGSize
        public init(size: CGSize = .init(width: 16, height: 8)) {
            self.size = size
        }
    }
    
    public struct TooltipConfig {
        let position: Position
        let fillColor: UIColor
        let collapseButtonConfig: CollapseButtonConfig?
        let contentView: UIView
        let arrowConfig: ArrowConfig
        public init(
            position: Position,
            fillColor: UIColor = .clear,
            collapseButtonConfig: CollapseButtonConfig? = .init(),
            contentView: UIView,
            arrowConfig: ArrowConfig = .init()
        ) {
            self.position = position
            self.fillColor = fillColor
            self.collapseButtonConfig = collapseButtonConfig
            self.contentView = contentView
            self.arrowConfig = arrowConfig
        }
    }
    
    public struct CollapseButtonConfig {
        let offset: CGFloat
        let image: UIImage?
        let size: CGSize
        
        public init(image: UIImage? = UIImage(systemName: "info.circle"), size: CGSize = .init(width: 56, height: 56), offset: CGFloat = 16) {
            self.image = image
            self.size = size
            self.offset = offset
        }
    }
    
    private let config: TooltipConfig
    private let contentView: UIView
    private let collapseButtonConfig: CollapseButtonConfig?
    private let arrowConfig: ArrowConfig
    
    private lazy var tooltipBackground = makeTooltipBackground()
    private lazy var arrowView = makeArrowView()
    private lazy var collapseButton = makeCollapseButton()
    
    public var didTapCollapseButton: (() -> Void)?
    
    public init(config: TooltipConfig) {
        self.config = config
        self.contentView = config.contentView
        self.collapseButtonConfig = config.collapseButtonConfig
        self.arrowConfig = config.arrowConfig
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        
        addSubview(tooltipBackground)
        addSubview(arrowView)
        tooltipBackground.addSubview(contentView)
        addSubview(collapseButton)
        
        calculateConstraints()
    }
    // Public method to display the tooltip in a view
    public func show(in view: UIView, anchorButton: UIView) {
        view.addSubview(self)
        switch config.position {
        case .top:
            self.snp.makeConstraints { make in
                make.centerX.equalTo(anchorButton.snp.centerX)
                make.bottom.equalTo(anchorButton.snp.top)
                make.horizontalEdges.equalToSuperview().inset(16) // FIXME
            }
        case .bottom:
            self.snp.makeConstraints { make in
                make.centerX.equalTo(anchorButton.snp.centerX)
                make.top.equalTo(anchorButton.snp.bottom)
                make.horizontalEdges.equalToSuperview().inset(16) // FIXME
            }
        case .right:
            self.snp.makeConstraints { make in
                make.centerY.equalTo(anchorButton.snp.centerY)
                make.left.equalTo(anchorButton.snp.right)
                make.right.equalToSuperview().offset(-16)
            }
        case .left:
            self.snp.makeConstraints { make in
                make.centerY.equalTo(anchorButton.snp.centerY)
                make.right.equalTo(anchorButton.snp.left)
                make.left.equalToSuperview().offset(16)
            }
        }
    
        
        // Appearance effect of the tooltip
        self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        self.alpha = 0
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.8,
                       options: .curveEaseOut,
                       animations: {
            self.transform = .identity
            self.alpha = 1
        })
    }
    
    public func makeCollapseButton() -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(systemName: "info.circle"), for: .normal)
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.didTapCollapseButton?()
        }), for: .touchUpInside)
        return button
    }
    
    // Public method to dismiss the tooltip
    public func dismiss() {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
            self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }) { _ in
            self.removeFromSuperview()
        }
    }
    
    private func calculateConstraints() {
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(24)
        }
        let offsetCollapseButton = config.collapseButtonConfig?.offset ?? 0
        switch config.position {
        case .top:
            collapseButton.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.size.equalTo(collapseButtonConfig?.size ?? 0)
                make.right.equalToSuperview().offset(offsetCollapseButton)
                make.centerY.equalTo(tooltipBackground.snp.top)
            }
            
            tooltipBackground.snp.makeConstraints { make in
                make.top.equalTo(collapseButton.snp.centerY)
                make.horizontalEdges.equalToSuperview()
            }
            
            arrowView.snp.makeConstraints { make in
                make.top.equalTo(tooltipBackground.snp.bottom)
                make.centerX.equalTo(tooltipBackground)
                make.size.equalTo(CGSize(width: 16, height: 8))
                make.bottom.equalToSuperview()
            }
        case .bottom:
            arrowView.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.centerX.equalToSuperview()
                make.size.equalTo(arrowConfig.size)
            }
            
            tooltipBackground.snp.makeConstraints { make in
                make.top.equalTo(arrowView.snp.bottom)
                make.horizontalEdges.equalToSuperview()
            }
            
            collapseButton.snp.makeConstraints { make in
                make.centerY.equalTo(tooltipBackground.snp.bottom)
                make.size.equalTo(collapseButtonConfig?.size ?? 0)
                make.right.equalToSuperview().offset(offsetCollapseButton)
                make.bottom.equalToSuperview()
            }
        case .right:
            arrowView.snp.makeConstraints { make in
                make.left.equalToSuperview()
                make.centerY.equalToSuperview()
                make.size.equalTo(arrowConfig.size)
            }
            
            tooltipBackground.snp.makeConstraints { make in
                make.verticalEdges.equalToSuperview()
                make.left.equalTo(arrowView.snp.right)
            }
            
            collapseButton.snp.makeConstraints { make in
                make.centerX.equalTo(tooltipBackground.snp.right)
                make.top.equalToSuperview().offset(offsetCollapseButton)
                make.right.equalToSuperview()
                make.size.equalTo(collapseButtonConfig?.size ?? .zero)
            }
        case .left:
            arrowView.snp.makeConstraints { make in
                make.right.equalToSuperview()
                make.centerY.equalToSuperview()
                make.size.equalTo(arrowConfig.size)
            }
            
            tooltipBackground.snp.makeConstraints { make in
                make.verticalEdges.equalToSuperview()
                make.right.equalTo(arrowView.snp.left)
            }
            
            collapseButton.snp.makeConstraints { make in
                make.centerX.equalTo(tooltipBackground.snp.left)
                make.top.equalToSuperview().offset(offsetCollapseButton)
                make.left.equalToSuperview()
                make.size.equalTo(collapseButtonConfig?.size ?? .zero)
            }
        }
    }
    
    private func makeTooltipBackground() -> UIView {
        let tooltipBackground = UIView()
        tooltipBackground.backgroundColor = config.fillColor
        tooltipBackground.layer.cornerRadius = 16
        return tooltipBackground
    }
    
    private func makeArrowView() -> ArrowView {
        let arrowView = ArrowView(position: config.position, fillColor: config.fillColor)
        arrowView.backgroundColor = .clear
        return arrowView
    }
}

extension TooltipView {
    class ArrowView: UIView {
        private let position: Position
        private let fillColor: UIColor
        init(position: Position, fillColor: UIColor) {
            self.position = position
            self.fillColor = fillColor
            super.init(frame: .zero)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func draw(_ rect: CGRect) {
            let path = UIBezierPath()
            switch position {
            case .top:
                path.move(to: CGPoint(x: rect.midX, y: rect.maxY))  // Tip of the arrow
                path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            case .bottom:
                path.move(to: CGPoint(x: rect.midX, y: rect.minY))  // Tip of the arrow
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
                path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            case .left:
                path.move(to: CGPoint(x: rect.maxX, y: rect.midY))  // Tip of the arrow
                path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
                path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
            case .right:
                path.move(to: CGPoint(x: rect.minX, y: rect.midY))  // Tip of the arrow
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            }
            path.close()
            fillColor.setFill()
            path.fill()
        }
    }
}

class ToolTipExCV: UIViewController {
    private let infoButton: UIButton = {
        let button = UIButton(type: .infoLight)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var toolTipView: TooltipView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(infoButton)
        setupConstraints()
        
        infoButton.addTarget(self, action: #selector(showToolTip), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        infoButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(30)
        }
    }

    @objc private func showToolTip() {
        toolTipView?.dismiss()
        
        let label = UILabel()
        label.text = "Hello"
        label.numberOfLines = 0
        let config = TooltipView.TooltipConfig(
            position: .right,
            fillColor: .red,
            collapseButtonConfig: .init(offset: 30),
            contentView: label,
            arrowConfig: .init(size: CGSize(width: 8, height: 16))
        )
        let toolTip = TooltipView(config: config)
        
        toolTip.show(in: view, anchorButton: infoButton)
        self.toolTipView = toolTip
        
        let tapOutsideGesture = UITapGestureRecognizer(target: self, action: #selector(dismissToolTip))
        view.addGestureRecognizer(tapOutsideGesture)
    }
    
    @objc private func dismissToolTip() {
        toolTipView?.dismiss()
        toolTipView = nil
    }
}

struct ToolTip_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            ToolTipExCV()
        }
    }
}



