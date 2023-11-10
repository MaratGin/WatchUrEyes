//
//  CheckEyeViewModel.swift
//  WatchUrEyes
//
//  Created by Marat Giniyatov on 03.06.2023.
//

import Foundation

protocol CheckEyeViewModelProtocol {
    func goToAvetistovMethod()
    func showDisclaimer(name: DisclaimerRoute)
    
}

class CheckEyeViewModel: CheckEyeViewModelProtocol {
     
    // MARK: - Variables
    
    var coordinator: EyeTestCoordinator
    
    // MARK: - Initialisation

    init(coordinator: EyeTestCoordinator ) {
        self.coordinator = coordinator
    }
    
    func goToAvetistovMethod() {
        coordinator.navigate(with: .avetisov)
    }
    
    func showDisclaimer(name: DisclaimerRoute) {
        coordinator.navigate(with: .disclaimer(name: name))
        
    }
}

