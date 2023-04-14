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
    private var workoutOffset = 0

    private let itemSubject = CurrentValueSubject<[FullWorkout], Never>([])
    
    var items: AnyPublisher<[FullWorkout], Never> {
        itemSubject.eraseToAnyPublisher()
    }
    
    init() {
        Task {
            do {
                _ = try await loadWorkouts()
            } catch {
                print(error)
            }
        }
    }
    
    func loadTrainers() async {
        do {
            _ = try await trainerService.loadTrainers()
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
            let workouts = try await workoutService.loadWorkouts(page: workoutOffset)
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
        workoutOffset += 10
        try await loadWorkouts()
    }
}
