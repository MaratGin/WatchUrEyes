//
//  TapBarCoordinator.swift
//  MaratBetProject
//
//  Created by Marat Giniyatov on 10.04.2022.
//

import Foundation
import UIKit

protocol TabBarcoordinatorProtocol: Coordinator {
    
}

class TabBarCoordinator: TabBarcoordinatorProtocol {
    
    // MARK: - Coordinators variables
    
    lazy var rootViewController = TabBarController()
    lazy var eyeTestCoordinator = EyeTestCoordinator()
    lazy var eyeExerciseCoordinator = EyeExerciseCoordinator()
    lazy var statisticsCoordinator = StatisticsCoordinator()

    
    // MARK: - Private variables
    
    private var mainCoordinator: MainCoordinator
    
    // MARK: - Initialization
    
    init(mainCoordinator: MainCoordinator ) {
        self.mainCoordinator = mainCoordinator
    }
    
    // MARK: - Routes
    
    enum  Route {
        case exercise
        case eyeTest
        case statistics
    }
    
    // MARK: - Navigation method
    
    func navigate(with route: Route) {
        switch route {
        case .exercise:
            rootViewController.selectedIndex = 0
        case .eyeTest:
            rootViewController.selectedIndex = 1
        case .statistics:
            rootViewController.selectedIndex = 2
//        case .leave:
//            mainCoordinator.navigate(with: .leave)
        }
    }
    
    // MARK: - TabBar configuration
    
    func configureMainController() -> UIViewController {
        
        let eyeExerciseViewController = eyeExerciseCoordinator.configureViewController()
        eyeExerciseViewController.tabBarItem = UITabBarItem(title: "Упражнения",
                                                 image: UIImage(systemName: "house"),
                                                 tag: 0)
        let eyeTestViewController = eyeTestCoordinator.configureViewController()
        eyeTestViewController.tabBarItem = UITabBarItem(title: "Проверка зрения",
                                                 image: UIImage(systemName: "chart.bar.fill"),
                                                 tag: 1)
        let statisticsController = statisticsCoordinator.configureViewController()
        statisticsController.tabBarItem = UITabBarItem(title: "Статистика",
                                                    image: UIImage(systemName: "person.crop.circle"),
                                                    tag: 2)
        rootViewController.viewControllers = [eyeExerciseViewController, eyeTestViewController, statisticsController]
        navigate(with: .eyeTest)
        return rootViewController
    }
}
