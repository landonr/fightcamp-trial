//
//  WorkoutDataService.swift
//  fightcamp-onsite
//
//  Created by Landon Rohatensky on 2023-04-14.
//

import Foundation

protocol IWorkoutDataService {
    func loadWorkouts() async throws -> WorkoutObject
}

class WorkoutDataService: IWorkoutDataService {
    let apiUrl = URL(string: "https://android-trial.fightcamp.io/workouts")!
    private var page = 0
    private var pageSize = 10
    
    func loadWorkouts() async throws -> WorkoutObject {
//        return try await GenericDataService.loadJSON(from: WorkoutDataService.apiUrl, page: page, pageSize: pageSize) { (result: Result<WorkoutObject, NetworkError>) in
//            switch result {
//                case .success(let workouts):
//                    print("Loaded \(workouts.items.count) workouts: \(workouts.items)")
//                case .failure(let error):
//                    print("Error: \(error)")
//                }
        return try await GenericDataService.loadJSON(from: apiUrl, page: page, pageSize: pageSize)
    }
}
