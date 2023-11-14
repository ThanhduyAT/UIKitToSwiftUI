//
//  AppCoordinator.swift
//  Test
//
//  Created by Thanh Duy on 09/11/2023.
//

import Foundation
import XCoordinator

enum AppRoute: Route {
    case login
    case home(StrongRouter<HomeRoute>?)
}

class AppCoordinator: NavigationCoordinator<AppRoute> {
    init() {
        super.init(initialRoute: .login)
    }
    
    
    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        switch route {
        case .login:
            let viewController = LoginViewController.instantiateFromNib()
            let viewModel = LoginViewModelImpl(router: unownedRouter)
            viewController.bind(to: viewModel)
            return .push(viewController)
        case .home(let routers):
            if let router = routers {
                return .presentFullScreen(router)
            }
            let alert = UIAlertController(
                title: "How would you like to login?",
                message: "Please choose the type of coordinator used for the `Home` scene.",
                preferredStyle: .alert)
            alert.addAction(
                .init(title: "\(HomeTabCoordinator.self)", style: .default) { [unowned self] _ in
                    self.trigger(.home(HomeTabCoordinator().strongRouter))
                }
            )
            return .present(alert)
        }
    }
}

