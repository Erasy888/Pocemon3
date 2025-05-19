//
//  PokeAPIResponse.swift
//  PokemonCatcher2
//
//  Created by Ерасыл on 19.05.2025.
//
import Foundation
struct PokeAPIResponse: Codable {
    let name: String
    let sprites: Sprites
    let types: [TypeEntry]
    
    struct Sprites: Codable {
        let front_default: String
    }
    
    struct TypeEntry: Codable {
        let type: TypeName
    }
    
    struct TypeName: Codable {
        let name: String
    }
}
