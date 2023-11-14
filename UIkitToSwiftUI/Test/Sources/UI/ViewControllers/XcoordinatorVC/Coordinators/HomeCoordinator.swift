//
//  HomeCoordinator.swift
//  Test
//
//  Created by Thanh Duy on 09/11/2023.
//

import Foundation
import XCoordinator

enum HomeRoute: Route {
    case news
    case account
}

class HomeTabCoordinator: TabBarCoordinator<HomeRoute> {
    private let newsRouter: StrongRouter<NewsRoute>
    private let accountRouter: StrongRouter<AccountRoute>
    
    convenience init() {
        let newsCoordinator = NewsCoordinator()
        newsCoordinator.rootViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .recents, tag: 0)

        let accountCoordinator = AccountCoordinator()
        accountCoordinator.rootViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)

        self.init(newsRouter: newsCoordinator.strongRouter,
                  accountRouter: accountCoordinator.strongRouter)
    }
    
    init(newsRouter: StrongRouter<NewsRoute>, accountRouter: StrongRouter<AccountRoute>) {
        self.newsRouter = newsRouter
        self.accountRouter = accountRouter
        super.init(tabs: [newsRouter, accountRouter], select: accountRouter)
    }
    
    override func prepareTransition(for route: HomeRoute) -> TabBarTransition {
        switch route {
        case .news:
            return .select(newsRouter)
        case .account:
            return .select(accountRouter)
        }
    }
}
