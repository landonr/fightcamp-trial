//
//  ViewModel.swift
//  fightcamp-onsite
//
//  Created by Landon Rohatensky on 2023-04-14.
//

import Foundation
import Combine

class ViewModel {
    private let workoutService: IWorkoutDataService = WorkoutDataService()
    private let trainerService: ITrainerDataService = TrainerDataService()
    private var workoutPage = 0

    private let itemSubject = CurrentValueSubject<[FullWorkout], Never>([])
    
    var items: AnyPublisher<[FullWorkout], Never> {
        itemSubject.eraseToAnyPublisher()
    }
    
    
    func loadTrainers() async {
        do {
            let trainers = try await trainerService.loadTrainers()
        } catch {
            print(error)
        }
    }
    
    func loadTrainer(id: Int) async throws -> Trainer {
        do {
            let trainer = try await trainerService.loadTrainer(id: id)
            return trainer
        } catch {
            print(error)
            throw error
        }
    }
    
    func loadWorkouts() async throws {
        do {
            let workouts = try await workoutService.loadWorkouts(page: workoutPage)
            for workout in workouts.items {
                let trainer = try await loadTrainer(id: workout.trainerID)
                var items = itemSubject.value
                items.append(FullWorkout(workout: workout, trainer: trainer))
                itemSubject.send(items)
            }
        } catch {
            print(error)
        }
    }
    
    func loadNextPage() async throws {
        workoutPage += 1
        try await loadWorkouts()
    }
}
