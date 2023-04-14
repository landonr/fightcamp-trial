//
//  WorkoutDataService.swift
//  fightcamp-onsite
//
//  Created by Landon Rohatensky on 2023-04-14.
//

import Foundation

protocol IFCDataService {
    func loadWorkouts() async throws -> WorkoutObject
}

enum APIUrls {
    case workouts
    case workoutID(String)
    case trainers
    case trainerID(String)
    
    var url: URL? {
        switch self {
        case .workouts:
            return URL(string: "https://android-trial.fightcamp.io/workouts")
        case .workoutID(let id):
            return URL(string: "https://android-trial.fightcamp.io/workouts/\(id)")
        case .trainers:
            return URL(string: "https://android-trial.fightcamp.io/trainers")
        case .trainerID(let id):
            return URL(string: "https://android-trial.fightcamp.io/trainers/\(id)")
        }
    }
}

class FCDataService: IFCDataService {
    private var page = 0
    private var pageSize = 10
    
    func loadWorkouts() async throws -> WorkoutObject {
        guard let url = APIUrls.workouts.url else {
            throw NetworkError.invalidURL
        }
        return try await GenericDataService.loadJSON(from: url, page: page, pageSize: pageSize)
    }
    
    func loadTrainers() async throws -> TrainerObject {
        guard let url = APIUrls.trainers.url else {
            throw NetworkError.invalidURL
        }
        return try await GenericDataService.loadJSON(from: url, page: page, pageSize: pageSize)
    }
}
