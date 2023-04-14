//
//  WorkoutDataService.swift
//  fightcamp-onsite
//
//  Created by Landon Rohatensky on 2023-04-14.
//

import Foundation

protocol ITrainerDataService {
    func loadTrainers() async throws -> TrainerObject
    func loadTrainer(id: Int) async throws -> Trainer
}

private enum APIUrls {
    case trainers
    case trainerID(Int)
    
    var url: URL? {
        switch self {
        case .trainers:
            return URL(string: "https://android-trial.fightcamp.io/trainers")
        case .trainerID(let id):
            return URL(string: "https://android-trial.fightcamp.io/trainers/\(id)")
        }
    }
}

class TrainerDataService: ITrainerDataService {
    private var trainerCache: [Trainer] = []

    func loadTrainers() async throws -> TrainerObject {
        guard let url = APIUrls.trainers.url else {
            throw NetworkError.invalidURL
        }
        let trainers: TrainerObject = try await GenericDataService.loadJSON(from: url)
        trainerCache = trainers.items
        return trainers
    }
    
    func loadTrainer(id: Int) async throws -> Trainer {
        if let trainer = trainerCache.filter { $0.id == id }.first {
            print("loaded trainer \(trainer.firstName) from cache")
            return trainer
        }

        guard let url = APIUrls.trainerID(id).url else {
            throw NetworkError.invalidURL
        }
        
        let trainer: Trainer = try await GenericDataService.loadJSON(from: url)
        trainerCache.append(trainer)
        return trainer
    }
}
