//
//  Router.swift
//  WatchUrEyes
//
//  Created by Marat Giniyatov on 02.06.2023.
//

import Foundation
import UIKit

protocol Coordinator {
    associatedtype Route
    func navigate(with route: Route)
}

extension Coordinator {
    func configureMainController() -> UIViewController {
        return UIViewController()
    }
}
