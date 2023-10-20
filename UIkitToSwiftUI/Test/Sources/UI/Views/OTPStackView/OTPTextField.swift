//
//  OTPTextField.swift
//  Test
//
//  Created by Thanh Duy on 20/10/2023.
//

import Foundation
import UIKit
import SwiftUI

class OTPTextField: UITextField {

    weak var previousTextField: OTPTextField?
    weak var nextTextField: OTPTextField?

    override func deleteBackward() {
        if text?.isEmpty == true {
            previousTextField?.becomeFirstResponder()
        } else {
            text = ""
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
        disableState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        textAlignment = .center
        adjustsFontSizeToFitWidth = false
        font = .systemFont(ofSize: 22, weight: .medium)
        textColor = .black
        keyboardType = .numberPad
        autocorrectionType = .yes
        backgroundColor = .white
    }
 
    func disableState() {
        layer.cornerRadius = 4
        layer.borderColor = UIColor.border.cgColor
        layer.borderWidth = 1.0
        backgroundColor = .white
    }
    
    func activeState() {
        layer.cornerRadius = 4
        layer.borderColor = UIColor.primary.cgColor
        layer.borderWidth = 1.0
        backgroundColor = .white
    }
    
    func inputedState() {
        layer.cornerRadius = 4
        layer.borderColor = UIColor.border.cgColor
        layer.borderWidth = 1.0
        backgroundColor = .background
    }
    
    func failureState() {
        layer.cornerRadius = 4
        layer.borderColor = UIColor.errorBorder.cgColor
        layer.borderWidth = 1.0
        backgroundColor = .lightRed
    }
}

extension OTPTextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        false
    }

    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        []
    }
}

struct OTPTextField_Preview: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            OTPTextField(frame: .zero)
        }
    }
}
