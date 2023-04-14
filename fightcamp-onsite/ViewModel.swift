//
//  ViewModel.swift
//  fightcamp-onsite
//
//  Created by Landon Rohatensky on 2023-04-14.
//

import Foundation

class ViewModel {
    private let dataService = WorkoutDataService()
    
    func loadWorkouts() async {
        let workouts = await dataService.loadWorkouts()
    }
}
