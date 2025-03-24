//import UIKit
//import FlexLayout
//import PinLayout
//
//class ChipsStackView: UIView {
//    
//    init() {
//        super.init(frame: .zero)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        let chipTitles = ["Anh Thinh giau vl", "Anh Thinh busmap", "Chip 3", "Chip 4", "Chip 5", "Nguyen Su Phuoc", "Le Yen Thanh"] // Example chips
//        let chipStackView = UIStackView()
//        chipStackView.axis = .vertical
//        chipStackView.alignment = .center
//        chipStackView.spacing = 8
//        
//        var currentRowStackView: UIStackView?
//        var currentRowWidth: CGFloat = 0
//        
//        for title in chipTitles {
//            let chipButton = ChipButton()
//            chipButton.setTitle(title, for: .normal)
//            chipButton.setTitleColor(.black, for: .normal)
//            
//            let chipWidth = chipButton.intrinsicContentSize.width
//            
//            // Printout current width and max width
//            print(currentRowWidth + chipWidth)
//            print(bounds.width)
//            print("-----")
//            // Check if adding the chip exceeds the width of the view
//            if currentRowStackView == nil || currentRowWidth + chipWidth + 8 > bounds.width {
//                currentRowStackView = UIStackView()
//                currentRowStackView?.axis = .horizontal
//                currentRowStackView?.alignment = .center
//                currentRowStackView?.spacing = 8
//                
//                chipStackView.addArrangedSubview(currentRowStackView!)
//                currentRowWidth = 0
//            }
//            
//            currentRowStackView?.addArrangedSubview(chipButton)
//            currentRowWidth += chipWidth + 8
//        }
//        
//        addSubview(chipStackView)
//        
//        chipStackView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            chipStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
//            chipStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
//            chipStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            chipStackView.leadingAnchor.constraint(equalTo: leadingAnchor)
//        ])
//    }
//}
