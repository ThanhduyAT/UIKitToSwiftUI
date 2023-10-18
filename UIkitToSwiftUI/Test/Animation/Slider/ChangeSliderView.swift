//
//  ChangeSliderView.swift
//  Test
//
//  Created by Thanh Duy on 21/08/2023.
//

import Foundation
import UIKit
import SwiftUI

class ChangeSliderViewController: UIViewController {

    var pic = UIImageView()
    var slide = UISlider()
    var currentView: UIView?

    var picWidth: NSLayoutConstraint!
    var picHeight: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        // ...

        picWidth = pic.widthAnchor.constraint(equalTo:  view.widthAnchor ,multiplier:  0.25)
        picHeight = pic.heightAnchor.constraint(equalTo:  view.heightAnchor ,multiplier:  0.25)
        NSLayoutConstraint.activate([
            slide.heightAnchor.constraint(equalTo:  view.heightAnchor ,multiplier:  0.25),
            slide.widthAnchor.constraint(equalTo:  view.widthAnchor ,multiplier:  0.25),
            slide.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant :0),
            slide.topAnchor.constraint(equalTo: pic.bottomAnchor, constant :0),

            pic.topAnchor.constraint(equalTo: view.topAnchor, constant :0),
            picWidth,
            picHeight,
            pic.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant :0),
        ])

        // ...
    }

    @objc func change(){
        picWidth.constant = CGFloat(slide.value) * view.frame.size.width * 0.25
        picHeight.constant = CGFloat(slide.value) * view.frame.size.height * 0.25
    }

}

struct ChangeSliderViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            ChangeSliderViewController()
        }
    }
}

