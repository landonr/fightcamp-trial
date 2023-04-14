//
//  ViewModel.swift
//  fightcamp-onsite
//
//  Created by Landon Rohatensky on 2023-04-14.
//

import Foundation

class ViewModel {
    private let dataService = FCDataService()
    
    func loadTrainers() async {
        do {
            let trainers = try await dataService.loadTrainers()
            print(trainers)
        } catch {
            print(error)
        }
    }
    
    func loadWorkouts() async {
        do {
            let workouts = try await dataService.loadWorkouts()
        } catch {
            print(error)
        }
    }
}
