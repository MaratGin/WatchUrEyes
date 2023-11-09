//
//  TabBarController.swift
//  WatchUrEyes
//
//  Created by Marat Giniyatov on 01.06.2023.
//

import Foundation
import UIKit

final class TabBarController: UITabBarController {
    
     enum tabBarItem: Int {
        case feed
        case exercise
        case check
        
        var title: String {
            
            switch self {
                
            case .feed:
                return "Лента"
                
            case .exercise:
                return "Профиль"
                
            case .check:
                return "Проверка зрения"
            }
        }
        
        var iconName: String {
            
            switch self {
                
            case .feed:
                return "house"
                
            case .exercise:
                return "person.crop.circle"
                
            case .check:
                return "chart.bar.fill"
            }
        }
        var colors: [UIColor: UIColor] {
            switch self {
                
            case .feed:
                return [UIColor(red: 126, green: 125, blue: 125, alpha: 1): UIColor(red: 125, green: 125, blue: 125, alpha: 1), UIColor(red: 125, green: 125, blue: 125, alpha: 1): UIColor(red: 125, green: 125, blue: 125, alpha: 1) ]
            case .exercise:
                return [UIColor(red: 127, green: 125, blue: 125, alpha: 1): UIColor(red: 125, green: 125, blue: 125, alpha: 1), UIColor(red: 125, green: 125, blue: 125, alpha: 1): UIColor(red: 125, green: 125, blue: 125, alpha: 1) ]
            case .check:
                return [UIColor(red: 128, green: 125, blue: 125, alpha: 1): UIColor(red: 125, green: 125, blue: 125, alpha: 1), UIColor(red: 125, green: 125, blue: 125, alpha: 1): UIColor(red: 125, green: 125, blue: 125, alpha: 1) ]
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        UITabBar.appearance().tintColor = .red
        UITabBar.appearance().unselectedItemTintColor = UIColor.systemPink
    }
    
     func setUpTabBar(eyeExerciseCoordinator: EyeExerciseCoordinator, eyeTestCoordinator: EyeTestCoordinator, statisticsCoordinator: StatisticsCoordinator) {
        let dataSource: [tabBarItem] = [.feed, .exercise, .check]
    
        self.viewControllers = dataSource.map {
            
            switch $0 {
                
            case .feed:
                let feedViewController = eyeExerciseCoordinator.configureViewController()
                
                return feedViewController
                
            case .exercise:
                let profileViewController = eyeTestCoordinator.configureViewController()
                
                return profileViewController

                
//                return self.wrappedInNavigationController(with: profileViewController, title: $0.title)
                
            case .check:
                let checkEyeSightViewController = statisticsCoordinator.configureViewController()
                
                return checkEyeSightViewController
                
//                return self.wrappedInNavigationController(with: checkEyeSightViewController, title: $0.title)
            }
        }
        self.viewControllers?.enumerated().forEach {
            
            $1.tabBarItem.title = dataSource[$0].title
            
            $1.tabBarItem.image = UIImage(systemName: dataSource[$0].iconName)
            
            $1.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: .zero, bottom: -5, right: .zero)
            
        }
        
    }
    
    private func wrappedInNavigationController(with: UIViewController, title: Any?) -> UINavigationController {
            return UINavigationController(rootViewController: with)

        }
    
}
