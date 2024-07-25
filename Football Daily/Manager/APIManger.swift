//
//  APIManger.swift
//  Football Daily
//
//  Created by Thomas Mani on 24/07/24.
//

import Foundation

class APIManager {
    private let baseUrl = "https://v3.football.api-sports.io/"
    private let apiKey = "e3c7913f3c042734478ac160fa691f9b"
    private let host = "v3.football.api-sports.io"
    
    func sendRequest<T: Codable, U: Codable>(endpoint: String, parameters: T, completion: @escaping (Result<U, Error>) -> Void) async {
        guard var urlComponents = URLComponents(string: baseUrl + endpoint) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        do {
            urlComponents.queryItems = try parameters.asDictionary().map({ (key, value) in
                URLQueryItem(name: key, value: value)
            })
            
            guard let url = urlComponents.url else {
                throw URLError(.badURL)
            }
            var request = URLRequest(url: url)
            request.addValue(apiKey, forHTTPHeaderField: "x-rapidapi-key")
            request.addValue(host, forHTTPHeaderField: "x-rapidapi-host")
            
            let (data, response) = try await URLSession.shared.data(for: request)
            guard response is HTTPURLResponse else {
                completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
                return
            }
            
            let decodedResponse = try JSONDecoder().decode(U.self, from: data)
            completion(.success(decodedResponse))
        } catch {
            completion(.failure(error))
        }
    }
    
    func sendRequest<U: Codable>(endpoint: String, completion: @escaping (Result<U, Error>) -> Void) async {
        guard let urlComponents = URLComponents(string: baseUrl + endpoint) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        do {
            guard let url = urlComponents.url else {
                throw URLError(.badURL)
            }
            var request = URLRequest(url: url)
            request.addValue(apiKey, forHTTPHeaderField: "x-rapidapi-key")
            request.addValue(host, forHTTPHeaderField: "x-rapidapi-host")
            
            let (data, response) = try await URLSession.shared.data(for: request)
            guard response is HTTPURLResponse else {
                completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
                return
            }
            
            let decodedResponse = try JSONDecoder().decode(U.self, from: data)
            completion(.success(decodedResponse))
        } catch {
            completion(.failure(error))
        }
    }
}
