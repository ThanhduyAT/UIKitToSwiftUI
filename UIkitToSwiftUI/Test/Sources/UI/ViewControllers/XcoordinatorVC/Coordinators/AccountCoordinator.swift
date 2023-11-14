//
//  AccountCoordinator.swift
//  Test
//
//  Created by Thanh Duy on 09/11/2023.
//

import Foundation
import XCoordinator

enum AccountRoute: Route {
    case option
}

class AccountCoordinator: NavigationCoordinator<AccountRoute> {
    init() {
        super.init(initialRoute: .option)
    }
    
    override func prepareTransition(for route: AccountRoute) -> NavigationTransition {
        switch route {
        case .option:
            let vc = OptionViewController()
            return .push(vc)
        }
    }
}
