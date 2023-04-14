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

private enum APIUrls {
    case workouts
    case workoutID(String)
    
    var url: URL? {
        switch self {
        case .workouts:
            return URL(string: "https://android-trial.fightcamp.io/workouts")
        case .workoutID(let id):
            return URL(string: "https://android-trial.fightcamp.io/workouts/\(id)")
        }
    }
}

class WorkoutDataService: IWorkoutDataService {
    private var page = 0
    private var pageSize = 10
    
    func loadWorkouts() async throws -> WorkoutObject {
        guard let url = APIUrls.workouts.url else {
            throw NetworkError.invalidURL
        }
        return try await GenericDataService.loadJSON(from: url, page: page, pageSize: pageSize)
    }
}
