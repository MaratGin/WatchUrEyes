//
//  MainRouter.swift
//  WatchUrEyes
//
//  Created by Marat Giniyatov on 01.06.2023.
//

import Foundation
import UIKit

protocol EyeTestCoordinatorProtocol: Coordinator {
    
}

class EyeTestCoordinator: EyeTestCoordinatorProtocol {
    
    private let navigationController = UINavigationController()

    internal enum Route {
        case eyeTest
        case avetisov
        case sivcev
    }
    
    
    func navigate(with route: Route) {
        switch route {
            
        case .eyeTest:
//            print("EyeTEstCoordinator")
            let viewModel = CheckEyeViewModel(coordinator: self)
            let viewController = CheckEyeController()
            viewController.viewModel = viewModel
            navigationController.pushViewController(viewController, animated: true)
            
        case .avetisov:
            let viewController = EyeSightViewController()
//            let viewController = CameraViewController()
            navigationController.pushViewController(viewController, animated: true)
            break
            
        case .sivcev:
            break
            
        }
    }
        
  
    
    func configureViewController() -> UIViewController {
        navigate(with: .eyeTest)
        return navigationController
    }
}

