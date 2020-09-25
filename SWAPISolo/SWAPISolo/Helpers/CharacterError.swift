//
//  CharacterError.swift
//  SWAPISolo
//
//  Created by Austin Goetz on 9/25/20.
//

import Foundation

enum CharacterError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case invalidData
}
