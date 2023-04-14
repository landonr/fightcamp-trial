//
//  WorkoutModel.swift
//  fightcamp-onsite
//
//  Created by Landon Rohatensky on 2023-04-14.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Workout
struct WorkoutObject: Codable {
    let items: [Item]
    let totalCount: Int

    enum CodingKeys: String, CodingKey {
        case items
        case totalCount = "total_count"
    }
}

// MARK: - Item
struct Item: Codable {
    let id: Int
    let title, desc: String
    let type: TypeEnum
    let added, nbrRounds: Int
    let previewImgURL: String
    let level: Level
    let trainerID: Int

    enum CodingKeys: String, CodingKey {
        case id, title, desc, type, added
        case nbrRounds = "nbr_rounds"
        case previewImgURL = "preview_img_url"
        case level
        case trainerID = "trainer_id"
    }
}

enum Level: String, Codable {
    case allLevels = "all_levels"
    case intermediate = "intermediate"
}

enum TypeEnum: String, Codable {
    case classic = "classic"
}
