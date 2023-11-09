//
//  MainRouter.swift
//  WatchUrEyes
//
//  Created by Marat Giniyatov on 01.06.2023.
//

import Foundation
import UIKit

protocol StatisticsCoordinatorProtocol: Coordinator {
    
}

class StatisticsCoordinator: StatisticsCoordinatorProtocol {
    
    private let navigationController = UINavigationController()

    internal enum Route {
        case statistics
        case avetisov
        case sivcev
    }
    
    
    func navigate(with route: Route) {
        switch route {
        case .statistics:
            let viewController = StatisticsViewController()
            navigationController.pushViewController(viewController, animated: true)
            
        case .avetisov:
            break
            
        case .sivcev:
            break
            
        }
    }
            
    func configureViewController() -> UIViewController {
        navigate(with: .statistics)
        return navigationController
    }
    
}

