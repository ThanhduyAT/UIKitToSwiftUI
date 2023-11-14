//
//  SegementedControlItem.swift
//  Test
//
//  Created by Thanh Duy on 13/11/2023.
//

import Foundation
import Parchment

struct SegementedControlItem: PagingItem, Hashable, Comparable {
    let index: Int
    let title: String
    let icon: String

    static func < (lhs: SegementedControlItem, rhs: SegementedControlItem) -> Bool {
        return lhs.index < rhs.index
    }
}
