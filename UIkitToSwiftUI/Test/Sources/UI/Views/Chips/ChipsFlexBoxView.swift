//import UIKit
//import FlexLayout
////import PinLayout
//
//class ChipsFlexBoxView: UIView {
//    fileprivate let rootFlexContainer = UIView()
//
//    init() {
//        super.init(frame: .zero)
//        let chipTitles = ["Anh Thinh giau vl", "Anh Thinh busmap", "Chip 3", "Chip 4", "Chip 5", "Nguyen Su Phuoc", "Le Yen Thanh"] // Example chips
//        
//        rootFlexContainer.flex.direction(.row).wrap(.wrap).justifyContent(.center).padding(8).define { (flex) in
//            for title in chipTitles {
//                let chipButton = ChipButton()
//                chipButton.setTitle(title, for: .normal)
//                chipButton.setTitleColor(.black, for: .normal)
//                flex.addItem(chipButton).margin(UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
//            }
//        }
//        addSubview(rootFlexContainer)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        rootFlexContainer.pin.all(pin.safeArea)
//        // Then let the flexbox container layout itself
//        rootFlexContainer.flex.layout()
//    }
//}
