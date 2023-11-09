//
//  OnboardingCoordinator.swift
//  MaratBet
//
//  Created by Marat Giniyatov on 16.03.2022.
//

import Foundation
import UIKit
protocol EnterViewCoordinatorProtocol: Coordinator {
}

// MARK: - Coordinator for Onboarding screen

public class EnterViewCoordinator: EnterViewCoordinatorProtocol {
    
    enum Route {
        case app
        case moveToApp
    }
    
    // MARK: - Variables
    
    private let navigationController = UINavigationController()
    var mainCoordinator: MainCoordinator?
    
    // MARK: - coordinator's navigation method
    
    func navigate(with route: Route) {
            switch route {
            case .app:
                let viewController = EnterViewController()
                viewController.coordinator = self
                print("EnterViewCoordinator")
                navigationController.pushViewController(viewController, animated: true)
            case .moveToApp:
                print("EnterViewCoordinator moveToApp")
                mainCoordinator?.navigate(with: .moveToApp)
            }
        }
        func configureMainController() -> UIViewController {
            navigate(with: .app)
            return navigationController
        }
    
    func renewMainController() -> UIViewController {
        var navigationArray = navigationController.viewControllers
        navigationArray.remove(at: navigationArray.count - 1)
        navigationController.viewControllers = navigationArray
        return navigationController
    }
}
