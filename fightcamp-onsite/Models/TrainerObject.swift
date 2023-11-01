//
//  TrainerObject.swift
//  fightcamp-onsite
//
//  Created by Landon Rohatensky on 2023-04-14.
//

import Foundation

// MARK: - Welcome
struct TrainerObject: Codable {
    let items: [Trainer]
}

// MARK: - Item
struct Trainer: Codable {
    let id: Int
    let firstName, lastName: String
    let photoURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photoURL = "photo_url"
    }
}
