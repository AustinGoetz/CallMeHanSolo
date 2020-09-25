//
//  CharacterController.swift
//  SWAPISolo
//
//  Created by Austin Goetz on 9/25/20.
//

import Foundation

//https://swapi.dev/api/people/1/

struct StringConstants {
    fileprivate static let baseURLString = "https://swapi.dev"
    fileprivate static let apiComponentString = "api"
    fileprivate static let peopleComponentString = "people"
}

class CharacterController {
    
    func fetchCharacterBy(id: Int, completion: @escaping (Result<Character, CharacterError>) -> Void) {
        guard let baseURL = URL(string: StringConstants.baseURLString) else { return completion(.failure(.invalidURL)) }
        let apiURL = baseURL.appendingPathComponent(StringConstants.apiComponentString)
        let peopleURL = apiURL.appendingPathComponent(StringConstants.peopleComponentString)
        let finalURL = peopleURL.appendingPathComponent(String(id))
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.invalidData)) }
            
            do {
                let decodedCharacter = try JSONDecoder().decode(Character.self, from: data)
                completion(.success(decodedCharacter))
            } catch {
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
}
