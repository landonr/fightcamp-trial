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
    private var workoutPage = 0

    func loadTrainers() async {
        do {
            let trainers = try await trainerService.loadTrainers()
        } catch {
            print(error)
        }
    }
    
    func loadTrainer(id: Int) async {
        do {
            let trainer = try await trainerService.loadTrainer(id: id)
        } catch {
            print(error)
        }
    }
    
    func loadWorkouts() async {
        do {
            let workouts = try await workoutService.loadWorkouts(page: workoutPage)
            for workout in workouts.items {
                await loadTrainer(id: workout.trainerID)
            }
        } catch {
            print(error)
        }
    }
    
    func loadNextPage() async {
        workoutPage += 1
        await loadWorkouts()
    }
}
