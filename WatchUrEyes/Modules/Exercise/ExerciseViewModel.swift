//
//  ExerciseViewModel.swift
//  WatchUrEyes
//
//  Created by Marat Giniyatov on 29.09.2023.
//

import Foundation

protocol ExerciseViewModelProtocol {
    func goToDetail()
    
}

class ExerciseViewModel: ExerciseViewModelProtocol {
    // MARK: - Variables
    
    var coordinator: EyeExerciseCoordinator
    
    // MARK: - Initialisation

    init(coordinator: EyeExerciseCoordinator ) {
        self.coordinator = coordinator
    }
    
    func goToDetail() {
        coordinator.navigate(with: .detailExercise)
    }
}

