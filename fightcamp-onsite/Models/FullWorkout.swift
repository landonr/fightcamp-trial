//
//  FullWorkout.swift
//  fightcamp-onsite
//
//  Created by Landon Rohatensky on 2023-04-14.
//

import Foundation

struct FullWorkout: Hashable {
    var workout: Workout
    var trainer: Trainer
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(workout.id)
    }
    
    static func == (lhs: FullWorkout, rhs: FullWorkout) -> Bool {
        lhs.workout.id == rhs.workout.id
    }
}
