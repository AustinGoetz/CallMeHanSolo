//
//  Character.swift
//  SWAPISolo
//
//  Created by Austin Goetz on 9/25/20.
//

import Foundation

struct Character: Decodable {
    let name: String
    let height: String
    let mass: String
    let hair_color: String
    let skin_color: String
    let eye_color: String
    let birth_year: String
    let gender: String
    let homeworld: String
}
