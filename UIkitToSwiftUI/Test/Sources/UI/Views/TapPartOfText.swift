//
//  TapPartOfText.swift
//  Test
//
//  Created by Thanh Duy on 22/06/2023.
//

import UIKit
import SnapKit
import SwiftUI

class TapPartOfText: UIView {
    private lazy var textString: UILabel = {
//        let text = "text okxe 123"
        let label = UILabel()
//        label.text = text
        label.textColor = .brown
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 40)
//        let underlineAttriString = NSMutableAttributedString(string: text)
//        let range1 = (text as NSString).range(of: "okxe")
//        underlineAttriString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range1)
//        underlineAttriString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 18), range: range1)
//        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIFont.systemFont(ofSize: 18), range: range1)
//        label.attributedText = underlineAttriString
//        label.addGestureRecognizer(gesture)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(textString)
        textString.snp.makeConstraints { make in
            make.left.right.bottom.top.equalToSuperview()
        }
        configDescriptionLabel()
//        config2()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError()
    }
    
    func configDescriptionLabel() {
        let strNumber: NSString = "text okxe 123 abc" as NSString
        let range = (strNumber).range(of: "okxe")
        let attribute = NSMutableAttributedString.init(string: strNumber as String)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue , range: range)
        textString.attributedText = attribute
    }
    
    func config2() {
        let strNumber: NSString = "text okxe 123 abc" as NSString
        let underlineAttriString = NSMutableAttributedString(string: strNumber as String)
        let range1 = (strNumber).range(of: "okxe 123")
        underlineAttriString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range1)
        underlineAttriString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 15), range: range1)
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: range1)
        
//        let range2 = (strNumber).range(of: "123")
//        underlineAttriString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range2)
//        underlineAttriString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 40), range: range2)
//        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: range2)
        
        textString.attributedText = underlineAttriString
        textString.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapLabel(gesture:))))
    }
    
    @objc func tapLabel(gesture: UITapGestureRecognizer) {
        let text = "text okxe 123 abc"
        let termsRange = (text as NSString).range(of: "okxe")
        
        let abcRange = (text as NSString).range(of: "123")
        // comment for now
        //let privacyRange = (text as NSString).range(of: "Privacy Policy")
        
        if gesture.didTapAttributedTextInLabel(label: textString, inRange: termsRange) {
            print("Tapped terms")
            textString.textColor = .red
        } else if gesture.didTapAttributedTextInLabel(label: textString, inRange: abcRange) {
            textString.textColor = .cyan
        }
    }
}

extension UITapGestureRecognizer {

    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)

        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize

        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        //let textContainerOffset = CGPointMake((labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
        //(labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)

        //let locationOfTouchInTextContainer = CGPointMake(locationOfTouchInLabel.x - textContainerOffset.x,
        // locationOfTouchInLabel.y - textContainerOffset.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
}

struct TapPartOfText_Preview: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            TapPartOfText()
        }
    }
}

