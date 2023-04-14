//
//  ViewModel.swift
//  fightcamp-onsite
//
//  Created by Landon Rohatensky on 2023-04-14.
//

import Foundation

class ViewModel {
    private let workoutService: IWorkoutDataService = WorkoutDataService()
    private let trainerService: ITrainerDataService = TrainerDataService()
    
    func loadTrainers() async {
        do {
            let trainers = try await trainerService.loadTrainers()
//            print(trainers)
        } catch {
            print(error)
        }
    }
    
    func loadTrainer(id: Int) async {
        do {
            let trainer = try await trainerService.loadTrainer(id: id)
            print(trainer)
        } catch {
            print(error)
        }
    }
    
    func loadWorkouts() async {
        do {
            let workouts = try await workoutService.loadWorkouts()
            for workout in workouts.items {
                await loadTrainer(id: workout.trainerID)
            }
        } catch {
            print(error)
        }
    }
}
