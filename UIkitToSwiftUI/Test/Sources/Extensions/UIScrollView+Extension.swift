//
//  UIScrollView+Extension.swift
//  Test
//
//  Created by Thanh Duy on 14/09/2023.
//

import UIKit

private var xoStickyHeaderKey: UInt8 = 0
extension UIScrollView {
    public var stickyHeader: TbStickyHeader! {
        
        get {
            var header = objc_getAssociatedObject(self, &xoStickyHeaderKey) as? TbStickyHeader
            
            if header == nil {
                header = TbStickyHeader()
                header!.scrollView = self
                objc_setAssociatedObject(self, &xoStickyHeaderKey, header, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            return header!
        }
    }
}
