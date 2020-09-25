//
//  CharacterController.swift
//  SWAPISolo
//
//  Created by Austin Goetz on 9/25/20.
//

import Foundation

//https://swapi.dev/api/people/?search=r2

struct StringConstants {
    fileprivate static let baseURLString = "https://swapi.dev"
    fileprivate static let apiComponentString = "api"
    fileprivate static let peopleComponentString = "people"
    fileprivate static let searchQueryString = "search"
}

class CharacterController {
    
    static func fetchCharacterWith(name: String, completion: @escaping (Result<[Character], CharacterError>) -> Void) {
        guard let baseURL = URL(string: StringConstants.baseURLString) else { return completion(.failure(.invalidURL)) }
        let apiURL = baseURL.appendingPathComponent(StringConstants.apiComponentString)
        let peopleURL = apiURL.appendingPathComponent(StringConstants.peopleComponentString)
        
        var components = URLComponents(url: peopleURL, resolvingAgainstBaseURL: true)
        let searchQuery = URLQueryItem(name: StringConstants.searchQueryString, value: name)
        
        components?.queryItems = [searchQuery]
        
        guard let finalURL = components?.url else { return completion(.failure(.invalidURL)) }
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.invalidData)) }
            
            do {
                let decodedTopLevelDict = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                let decodedCharacters = decodedTopLevelDict.results
                completion(.success(decodedCharacters))
            } catch {
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
}
