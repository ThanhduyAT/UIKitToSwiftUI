//
//  OTPStackView.swift
//  Test
//
//  Created by Thanh Duy on 20/10/2023.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import SwiftUI

class OTPStackView: UIStackView {
    
    var numberOfFields = 6
    var widthOfTextField = CGFloat(50)
    var fillFullOTP = PublishSubject<Bool>()
    var inputOTPString = PublishSubject<String?>()
    
    private var textFields = [OTPTextField]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }

    private func initialize() {
        setupStackView()
        createTextFields()
    }
    
    private final func setupStackView() {
        backgroundColor = .clear
        isUserInteractionEnabled = true
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .center
        distribution = .fillEqually
        spacing = 8
    }
    
    private func createTextFields() {
        for index in 0..<numberOfFields {
            let textField = OTPTextField(frame: .zero)
            setupTextField(textField)
            textFields.append(textField)
            index != 0 ? (textField.previousTextField = textFields[index-1]) : (textField.previousTextField = nil)
            index != 0 ? (textFields[index-1].nextTextField = textField) : ()
        }
        if #available(iOS 12.0, *) {
            textFields.first?.textContentType = .oneTimeCode
        }
    
        textFields.first?.becomeFirstResponder()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.recieveAutoFillOTP(notification:)),
            name: UITextField.textDidChangeNotification,
            object: nil)
    }
    
    @objc func recieveAutoFillOTP(notification: NSNotification) {
        if let textField = notification.object as? OTPTextField,
           let string = textField.text {
            if string.count > 1 {
                clearOldInputOTP()
            } else {
                checkFillFullOTP()
            }
        }
    }
    
    private final func setupTextField(_ textField: OTPTextField){
        textField.delegate = self
        addArrangedSubview(textField)
        textField.snp.makeConstraints { make in
            make.height.equalTo(self)
            make.width.equalTo(widthOfTextField)
        }
    }
    
    private final func autoFillOTP(with string: String) {
        var remainingStrStack = string.reversed().map { String($0) }
        for textField in textFields {
            if let charToAdd = remainingStrStack.popLast() {
                textField.text = String(charToAdd)
            } else {
                break
            }
        }
        
        checkFillFullOTP()
    }
    
    private func checkFillFullOTP() {
        for textField in textFields where textField.text?.isEmpty == true {
            fillFullOTP.onNext(false)
            return
        }
        collectInputOTPs()
        fillFullOTP.onNext(true)
        textFields.last?.disableState()
        textFields.last?.inputedState()
    }
    
    private func collectInputOTPs() {
        let inputString = textFields.compactMap { $0.text }.joined(separator: "")
        inputOTPString.onNext(inputString)
    }
    
    func clearOldInputOTP() {
        textFields.forEach { textField in
            textField.text = ""
            textField.disableState()
        }
        
        textFields.first?.becomeFirstResponder()
    }
    
    func changeToFailureState() {
        textFields.forEach { textField in
            textField.failureState()
        }
    }
    
    func resetFocusing() {
        textFields.first?.becomeFirstResponder()
    }
}

extension OTPStackView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        (textField as? OTPTextField)?.activeState()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.isEmpty == false {
            (textField as? OTPTextField)?.inputedState()
        } else {
            (textField as? OTPTextField)?.disableState()
        }
    }
    
    func textField(_ textFields: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textField = textFields as? OTPTextField else { return true }
        if string.count > 1 {
            textField.resignFirstResponder()
            autoFillOTP(with: string)
            return false
        } else if range.length == 0 {
            if textField.nextTextField == nil {
                textField.text? = string
            } else if !string.isEmpty {
                textField.text? = string
                textField.nextTextField?.becomeFirstResponder()
            }
            checkFillFullOTP()
            return false
        }
        return true
    }
}

struct OTPStackView_Preview: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            OTPStackView()
        }
    }
}
