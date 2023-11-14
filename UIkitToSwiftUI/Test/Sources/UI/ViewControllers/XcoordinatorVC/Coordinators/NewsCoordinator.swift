//
//  NewsCoordinator.swift
//  Test
//
//  Created by Thanh Duy on 09/11/2023.
//

import Foundation
import XCoordinator

enum NewsRoute: Route {
    case news
    case newsDetail
}

class NewsCoordinator: NavigationCoordinator<NewsRoute> {
    init() {
        super.init(initialRoute: .news)
    }
    
    override func prepareTransition(for route: NewsRoute) -> NavigationTransition {
        switch route {
        case .news:
            let vc = SkeletonViewController()
            return .push(vc)
        case .newsDetail:
            let vc = SkeletonViewController()
            return .push(vc)
        }
    }
}
