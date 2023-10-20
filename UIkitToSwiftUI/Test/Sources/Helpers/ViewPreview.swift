//
//  ViewPreview.swift
//  Test
//
//  Created by Thanh Duy on 20/10/2023.
//

import Foundation
import UIKit
import SwiftUI

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
