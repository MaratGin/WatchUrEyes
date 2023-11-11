//
//  MainRouter.swift
//  WatchUrEyes
//
//  Created by Marat Giniyatov on 01.06.2023.
//

import Foundation
import UIKit

protocol EyeExercieseCoordinatorProtocol: Coordinator {
    
}

class EyeExerciseCoordinator: EyeTestCoordinatorProtocol {
    
    private let navigationController = UINavigationController()
   
    internal enum Route {
        case eyeExercise
        case detailExercise
        case sivcev
    }
    
    func navigate(with route: Route) {
        switch route {
        
        case .eyeExercise:
            let viewController = EyeExerciseViewController()
            viewController.viewModel = ExerciseViewModel(coordinator: self)
            navigationController.pushViewController(viewController, animated: true)
            
        case .detailExercise:
//            let viewController = ExerciseDetailViewController()
//            navigationController.pushViewController(viewController, animated: true)
            break
            
        case .sivcev:
            break
            
        }
    }
        
    func configureViewController() -> UIViewController {
        navigate(with: .eyeExercise)
        return navigationController

    }
    
}

