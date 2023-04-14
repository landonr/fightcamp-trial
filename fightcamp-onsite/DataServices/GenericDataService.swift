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
    static func loadJSON<T: Decodable>(from url: URL, page: Int = 1, pageSize: Int = 20, completion: @escaping (Result<T, NetworkError>) -> Void) {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "pageSize", value: "\(pageSize)")
        ]
        
        guard let apiUrl = components?.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: apiUrl) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let decodedObject = try jsonDecoder.decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch let error {
                completion(.failure(.jsonDecodingFailed(error)))
            }
        }.resume()
    }
}
