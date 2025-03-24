//
//  SkeletonVM.swift
//  Test
//
//  Created by Duy Thanh on 24/07/2024.
//

import Foundation
import Combine

class SkeletonVM {
    @Published var item: [Item] = [
        .init(title: "test1", description: "test1111111 test1111111 test1111111 test1111111 test1111111 test1111111 test1111111 test1111111 test1111111"),
        .init(title: "test2", description: "test2222222 test2222222 test2222222 test2222222 test2222222 test2222222 test2222222 test2222222 test2222222"),
        .init(title: "test3", description: "test3333333 test3333333 test3333333 test3333333 test3333333 test3333333 test3333333 test3333333 test3333333"),
        .init(title: "test4", description: "test4444444 test4444444 test4444444 test4444444 test4444444 test4444444 test4444444 test4444444 test4444444"),
    ]
}

extension SkeletonVM  {
    enum Section: Hashable {
        case main
    }
    
    public struct Item: Hashable {
        var title: String
        var description: String
        
        init(title: String, description: String) {
            self.title = title
            self.description = description
        }
    }
}
