//
//  Character.swift
//  SWAPISolo
//
//  Created by Austin Goetz on 9/25/20.
//

import Foundation

struct TopLevelDictionary: Decodable {
    let results: [Character]
}

struct Character: Decodable {
    let name: String
    let height: String
    let mass: String
    let hairColor: String
    let skinColor: String
    let eyeColor: String
    let birthYear: String
    let gender: String
    let homeworld: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case height
        case mass
        case hairColor = "hair_color"
        case skinColor = "skin_color"
        case eyeColor = "eye_color"
        case birthYear = "birth_year"
        case gender
        case homeworld
    }
}
