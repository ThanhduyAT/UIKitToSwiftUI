import Foundation
import UIKit
import SnapKit
import SwiftUI

class TestTextFieldViewController: UIViewController {
    private lazy var textFieldView: UITextField = {
        let v = UITextField()
        v.placeholder = "OCB 123"
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        textFieldView.autocapitalizationType = .allCharacters
        
        view.addSubview(textFieldView)
        textFieldView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(300)
        }
    }
}

#Preview {
    ViewControllerPreview {
        TestTextFieldViewController()
    }
}
