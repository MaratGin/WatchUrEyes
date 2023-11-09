//
//  MainCoordinator.swift
//  WatchUrEyes
//
//  Created by Marat Giniyatov on 02.06.2023.
//

import Foundation
import UIKit

//
//  MainCoordinator.swift
//  MaratBetProject
//
//  Created by Marat Giniyatov on 05.04.2023.
//

// MARK: - Main coordinator

class MainCoordinator: Coordinator {

    enum Route {
        case logIn
        case moveToApp
    }
    
    private let window: UIWindow
    let navigationController = UINavigationController()
    

    
    init(window: UIWindow) {
        self.window = window
    }
    
    private lazy var enterViewCoordinator: EnterViewCoordinator = {
        let coordinator = EnterViewCoordinator()
        coordinator.mainCoordinator = self
        return coordinator
    }()
    
    private lazy var tabBarCoordinator: TabBarCoordinator = {
       let coordinator = TabBarCoordinator(mainCoordinator: self)
        return coordinator
    }()
    
    // MARK: - Navigation method
    
    func navigate(with route: Route) {
        switch route {
        case .logIn:
            print("Main Coordinator")
            setRootViewController(viewController: enterViewCoordinator.configureMainController())
        case .moveToApp:
            print("Main Coordinator moveToApp ")
            setRootViewController(viewController: tabBarCoordinator.configureMainController())
            
        }
    }
    
    func setRootViewController(viewController: UIViewController) {
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        UIView.transition(
            with: window,
            duration: 1.0,
            options: .transitionCrossDissolve,
            animations: nil,
            completion: nil
        )
    }
}
