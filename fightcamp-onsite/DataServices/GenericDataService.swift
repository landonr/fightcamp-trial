//
//  GenericDataService.swift
//  fightcamp-onsite
//
//  Created by Landon Rohatensky on 2023-04-14.
//
//  shout out chat gpt

import Foundation

struct Response<T: Codable>: Codable {
    let data: T
}

struct Paging<T: Codable>: Codable {
    let items: [T]
    let nextPage: Int?
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case requestFailed(Error)
    case jsonDecodingFailed(Error)
}

class GenericDataService {
    static func loadJSON<T: Decodable>(from url: URL, page: Int = 0, pageSize: Int = 20) async throws -> T {
        print("loading \(url) page: \(page)")

        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = [
            URLQueryItem(name: "offset", value: "\(page)")
        ]

        guard let apiUrl = components?.url else {
            throw NetworkError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: apiUrl)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }

        do {
            let jsonDecoder = JSONDecoder()
            let decodedObject = try jsonDecoder.decode(T.self, from: data)
            return decodedObject
        } catch let error {
            throw NetworkError.jsonDecodingFailed(error)
        }
    }

}
