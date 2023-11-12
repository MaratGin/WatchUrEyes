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
        case exercise(type: ExerciseMethod)
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
            
        case .exercise(let type):
            switch type {
            case .bliz:
                let viewController = ExerciseViewController()
                viewController.exercise = type
                navigationController.pushViewController(viewController, animated: true)
                
            case .daln:
                let viewController = ExerciseViewController()
                viewController.exercise = type
                navigationController.pushViewController(viewController, animated: true)
                
            case .relax:
                let viewController = ExerciseViewController()
                viewController.exercise = type
                navigationController.pushViewController(viewController, animated: true)
            }
            
        }
    }
        
    func configureViewController() -> UIViewController {
        navigate(with: .eyeExercise)
        return navigationController

    }
    
}

